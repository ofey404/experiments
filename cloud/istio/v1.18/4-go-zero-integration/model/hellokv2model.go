package model

import (
	"context"

	"github.com/zeromicro/go-zero/core/stores/mon"
	"go.mongodb.org/mongo-driver/bson"
)

var _ HelloKv2Model = (*customHelloKv2Model)(nil)

type (
	// HelloKv2Model is an interface to be customized, add more methods here,
	// and implement the added methods in customHelloKv2Model.
	HelloKv2Model interface {
		helloKv2Model
		FindAllByFilter(ctx context.Context, filter any) ([]*HelloKv2, error)
		FindByKey(ctx context.Context, key string) ([]*HelloKv2, error)
	}

	customHelloKv2Model struct {
		*defaultHelloKv2Model
	}
)

// NewHelloKv2Model returns a model for the mongo.
func NewHelloKv2Model(url, db, collection string) HelloKv2Model {
	conn := mon.MustNewModel(url, db, collection)
	return &customHelloKv2Model{
		defaultHelloKv2Model: newDefaultHelloKv2Model(conn),
	}
}

func (c *customHelloKv2Model) FindAllByFilter(ctx context.Context, filter any) ([]*HelloKv2, error) {
	var data []*HelloKv2
	err := c.conn.Find(ctx, &data, filter)
	switch err {
	case nil:
		return data, nil
	case mon.ErrNotFound:
		return nil, ErrNotFound
	default:
		return nil, err
	}
}

func (c *customHelloKv2Model) FindByKey(ctx context.Context, key string) ([]*HelloKv2, error) {
	return c.FindAllByFilter(ctx, bson.D{{Key: "key", Value: key}})
}
