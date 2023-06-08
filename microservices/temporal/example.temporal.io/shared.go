package app

type BankingService interface {
	Withdraw(accountNumber string, amount int, referenceID string) (string, error)
	Deposit(accountNumber string, amount int, referenceID string) (string, error)
}
