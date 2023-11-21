// Code generated by ent, DO NOT EDIT.

package ent

import (
	"fmt"
	"strings"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/ent/kvpair"
)

// KVPair is the model entity for the KVPair schema.
type KVPair struct {
	config `json:"-"`
	// ID of the ent.
	ID int `json:"id,omitempty"`
	// Key holds the value of the "key" field.
	Key string `json:"key,omitempty"`
	// Value holds the value of the "value" field.
	Value        string `json:"value,omitempty"`
	selectValues sql.SelectValues
}

// scanValues returns the types for scanning values from sql.Rows.
func (*KVPair) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case kvpair.FieldID:
			values[i] = new(sql.NullInt64)
		case kvpair.FieldKey, kvpair.FieldValue:
			values[i] = new(sql.NullString)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the KVPair fields.
func (kp *KVPair) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case kvpair.FieldID:
			value, ok := values[i].(*sql.NullInt64)
			if !ok {
				return fmt.Errorf("unexpected type %T for field id", value)
			}
			kp.ID = int(value.Int64)
		case kvpair.FieldKey:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field key", values[i])
			} else if value.Valid {
				kp.Key = value.String
			}
		case kvpair.FieldValue:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field value", values[i])
			} else if value.Valid {
				kp.Value = value.String
			}
		default:
			kp.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// GetValue returns the ent.Value that was dynamically selected and assigned to the KVPair.
// This includes values selected through modifiers, order, etc.
func (kp *KVPair) GetValue(name string) (ent.Value, error) {
	return kp.selectValues.Get(name)
}

// Update returns a builder for updating this KVPair.
// Note that you need to call KVPair.Unwrap() before calling this method if this KVPair
// was returned from a transaction, and the transaction was committed or rolled back.
func (kp *KVPair) Update() *KVPairUpdateOne {
	return NewKVPairClient(kp.config).UpdateOne(kp)
}

// Unwrap unwraps the KVPair entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (kp *KVPair) Unwrap() *KVPair {
	_tx, ok := kp.config.driver.(*txDriver)
	if !ok {
		panic("ent: KVPair is not a transactional entity")
	}
	kp.config.driver = _tx.drv
	return kp
}

// String implements the fmt.Stringer.
func (kp *KVPair) String() string {
	var builder strings.Builder
	builder.WriteString("KVPair(")
	builder.WriteString(fmt.Sprintf("id=%v, ", kp.ID))
	builder.WriteString("key=")
	builder.WriteString(kp.Key)
	builder.WriteString(", ")
	builder.WriteString("value=")
	builder.WriteString(kp.Value)
	builder.WriteByte(')')
	return builder.String()
}

// KVPairs is a parsable slice of KVPair.
type KVPairs []*KVPair
