package app

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"math"
	"time"
)

// Run is the entry point for our program
func Run(queue Queue, persistence Persistence, bank BankingService) {
	worker := Worker{queue, persistence, bank}
	handleErrors := func(consumer func(ctx context.Context, task Task) error) Consumer {
		return func(ctx context.Context, task Task) {
			err := consumer(ctx, task)
			if err != nil {
				log.Printf("Failed to process task: %v", err)
				queue.RetryLater(task, calcBackoff(task))
			} else {
				queue.Ack(task)
			}
		}
	}

	queue.Consume("money-transfer-events", handleErrors(worker.ProcessMoneyTransferEvent))
	queue.Consume("money-transfer-activities", handleErrors(worker.ProcessActivity))
}

type Status uint32

const (
	Started Status = iota
	Failed
	Succeeded
	Withdrawing
	Depositing
	Refunding
)

// ErrStorageConflict is returned by the storage API for the CompareAndSwap operation
var ErrStorageConflict = errors.New("storage conflict")

// ErrInsufficientFunds is returned by the bank API, considered a non-retryable business level error
var ErrInsufficientFunds = errors.New("insufficient funds")

// ErrAccountNotFound is returned by the bank API, considered a non-retryable business level error
var ErrAccountNotFound = errors.New("account not found")

type Persistence interface {
	Load(ctx context.Context, key string) (state interface{}, err error)
	CompareAndSwap(ctx context.Context, key string, state interface{}, expected interface{}) error
}

// Task pulled off a persistent task queue
type Task struct {
	QueueName string
	Payload   []byte
	Attempt   uint
}

type Consumer func(ctx context.Context, task Task)

// Queue represents a persistent task queue
type Queue interface {
	Enqueue(queue string, payload []byte) error
	Consume(queue string, consumer Consumer)
	Ack(task Task)
	RetryLater(task Task, duration time.Duration)
}

type TransactionInput struct {
	ReferenceID     string
	SourceAccountID string
	TargetAccountID string
	Amount          int
	// Used to report errors from activities
	ErrorMessage string
	// Used to verify process consistency
	LastStatus Status
}

type ActivityInput struct {
	Type      string
	AccountID string
	// Used to extract information about the transaction and forward it back to the transaction handler
	Transaction TransactionInput
}

type Worker struct {
	queue       Queue
	persistence Persistence
	bank        BankingService
}

func (w *Worker) ProcessMoneyTransferEvent(ctx context.Context, task Task) error {
	var input TransactionInput
	if err := json.Unmarshal(task.Payload, &input); err != nil {
		log.Printf("Failed to unmarshal payload: %v", err)
		// Enqueue in dead letter queue for human inspection
		return moveToDeadLetterQueue(w.queue, task)
	}
	anyStatus, err := w.persistence.Load(ctx, input.ReferenceID)
	if err != nil {
		return err
	}
	status, ok := anyStatus.(Status)
	if !ok {
		log.Printf("Failed to load status from DB, got: %v", anyStatus)
		return nil // discard this task, we don't know what to do with it
	}
	if status < input.LastStatus {
		// CompareAndSwap for the previous ProcessMoneyTransferEvent iteration has not completed before we got an activity completion.
		// Return an error and backoff retrying this task until our process is in consistent sate.
		return errors.New("got activity completion for uncommited workflow state")
	}
	if status > input.LastStatus {
		log.Printf("Invalid status in task, got: %v, expected: %v", input.LastStatus, status)
		return nil // discard this task, we probably generated duplicate activities due to a crash before committing previous status
	}

	prevStatus := status

	switch status {
	case Started:
		status = Withdrawing
		activityInput := ActivityInput{Type: "withdraw", AccountID: input.SourceAccountID, Transaction: input}
		if err := scheduleActivity(w.queue, activityInput); err != nil {
			return err
		}
	case Withdrawing:
		if input.ErrorMessage != "" {
			// Could not withdraw, abort
			status = Failed
		} else {
			status = Depositing
			activityInput := ActivityInput{Type: "deposit", AccountID: input.TargetAccountID, Transaction: input}
			if err := scheduleActivity(w.queue, activityInput); err != nil {
				return err
			}
		}
	case Depositing:
		if input.ErrorMessage != "" {
			status = Refunding
			// Reset the error message
			input.ErrorMessage = ""
			activityInput := ActivityInput{Type: "refund", AccountID: input.SourceAccountID, Transaction: input}
			if err := scheduleActivity(w.queue, activityInput); err != nil {
				return err
			}
		} else {
			status = Succeeded
		}
	case Refunding:
		if input.ErrorMessage != "" {
			// Critical transaction failure, cannot refund.
			// In a real world example a human operator would probably need to examine this transaction.
			status = Failed
		} else {
			status = Succeeded
		}
	default:
		return nil // discard this task, transaction has already completed. This shouldn't happen
	}

	// Since we already enqueued tasks before storing the state we might generate duplicate tasks in case storage returns an error.
	// This is okay for our case because we use a unique transaction ID as an idempotency token.
	// Temporal prevents this situation by committing workflow state and the request to schedule an activity in a single transaction.
	// This API will fail in case the status was incremented concurrently.
	err = w.persistence.CompareAndSwap(ctx, input.ReferenceID, status, prevStatus)
	if err != nil && !errors.Is(err, ErrStorageConflict) {
		return err
	}
	return nil
}

func (w *Worker) ProcessActivity(ctx context.Context, task Task) error {
	var input ActivityInput
	if err := json.Unmarshal(task.Payload, &input); err != nil {
		log.Printf("Failed to unmarshal payload: %v", err)
		return moveToDeadLetterQueue(w.queue, task)
	}
	tx := input.Transaction

	var operationErr error
	switch input.Type {
	case "deposit":
		_, operationErr = w.bank.Deposit(input.AccountID, tx.Amount, fmt.Sprintf("%s-deposit", tx.ReferenceID))
	case "withdraw":
		_, operationErr = w.bank.Withdraw(input.AccountID, tx.Amount, fmt.Sprintf("%s-withdraw", tx.ReferenceID))
	case "refund":
		_, operationErr = w.bank.Deposit(input.AccountID, tx.Amount, fmt.Sprintf("%s-refund", tx.ReferenceID))
	default:
		operationErr = fmt.Errorf("not implemented")
	}

	if operationErr != nil {
		if errors.Is(operationErr, ErrAccountNotFound) || errors.Is(operationErr, ErrInsufficientFunds) {
			// Business error, report back to transaction task
			tx.ErrorMessage = operationErr.Error()
		} else {
			// Transient error, retry later
			return operationErr
		}
	}
	payload, err := json.Marshal(tx)
	if err != nil {
		log.Printf("Failed to marshal payload: %v", err)
		// Enqueue in dead letter queue for human inspection
		return moveToDeadLetterQueue(w.queue, task)
	}
	if err := w.queue.Enqueue("transactions", payload); err != nil {
		return err
	}
	return nil
}

func scheduleActivity(queue Queue, input ActivityInput) error {
	payload, err := json.Marshal(input)
	if err != nil {
		return err
	}
	return queue.Enqueue("money-transfer-activities", payload)
}

// calcBackoff calculates exponential backoff without jitter
func calcBackoff(task Task) time.Duration {
	initialInterval := float64(time.Millisecond) * 500
	return time.Duration(initialInterval * math.Pow(2, float64(task.Attempt)))
}

func moveToDeadLetterQueue(queue Queue, task Task) error {
	return queue.Enqueue(fmt.Sprintf("%s-DLQ", task.QueueName), task.Payload)
}
