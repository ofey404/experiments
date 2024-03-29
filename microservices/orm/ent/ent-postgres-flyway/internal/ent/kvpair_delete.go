// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent/kvpair"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent/predicate"
)

// KVPairDelete is the builder for deleting a KVPair entity.
type KVPairDelete struct {
	config
	hooks    []Hook
	mutation *KVPairMutation
}

// Where appends a list predicates to the KVPairDelete builder.
func (kpd *KVPairDelete) Where(ps ...predicate.KVPair) *KVPairDelete {
	kpd.mutation.Where(ps...)
	return kpd
}

// Exec executes the deletion query and returns how many vertices were deleted.
func (kpd *KVPairDelete) Exec(ctx context.Context) (int, error) {
	return withHooks(ctx, kpd.sqlExec, kpd.mutation, kpd.hooks)
}

// ExecX is like Exec, but panics if an error occurs.
func (kpd *KVPairDelete) ExecX(ctx context.Context) int {
	n, err := kpd.Exec(ctx)
	if err != nil {
		panic(err)
	}
	return n
}

func (kpd *KVPairDelete) sqlExec(ctx context.Context) (int, error) {
	_spec := sqlgraph.NewDeleteSpec(kvpair.Table, sqlgraph.NewFieldSpec(kvpair.FieldID, field.TypeInt))
	if ps := kpd.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	affected, err := sqlgraph.DeleteNodes(ctx, kpd.driver, _spec)
	if err != nil && sqlgraph.IsConstraintError(err) {
		err = &ConstraintError{msg: err.Error(), wrap: err}
	}
	kpd.mutation.done = true
	return affected, err
}

// KVPairDeleteOne is the builder for deleting a single KVPair entity.
type KVPairDeleteOne struct {
	kpd *KVPairDelete
}

// Where appends a list predicates to the KVPairDelete builder.
func (kpdo *KVPairDeleteOne) Where(ps ...predicate.KVPair) *KVPairDeleteOne {
	kpdo.kpd.mutation.Where(ps...)
	return kpdo
}

// Exec executes the deletion query.
func (kpdo *KVPairDeleteOne) Exec(ctx context.Context) error {
	n, err := kpdo.kpd.Exec(ctx)
	switch {
	case err != nil:
		return err
	case n == 0:
		return &NotFoundError{kvpair.Label}
	default:
		return nil
	}
}

// ExecX is like Exec, but panics if an error occurs.
func (kpdo *KVPairDeleteOne) ExecX(ctx context.Context) {
	if err := kpdo.Exec(ctx); err != nil {
		panic(err)
	}
}
