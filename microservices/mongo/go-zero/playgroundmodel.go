package model

import "github.com/zeromicro/go-zero/core/stores/mon"

var _ PlaygroundModel = (*customPlaygroundModel)(nil)

type (
	// PlaygroundModel is an interface to be customized, add more methods here,
	// and implement the added methods in customPlaygroundModel.
	PlaygroundModel interface {
		playgroundModel
	}

	customPlaygroundModel struct {
		*defaultPlaygroundModel
	}
)

// NewPlaygroundModel returns a model for the mongo.
func NewPlaygroundModel(url, db, collection string) PlaygroundModel {
	conn := mon.MustNewModel(url, db, collection)
	return &customPlaygroundModel{
		defaultPlaygroundModel: newDefaultPlaygroundModel(conn),
	}
}
