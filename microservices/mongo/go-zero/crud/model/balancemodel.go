package model

import "github.com/zeromicro/go-zero/core/stores/mon"

var _ BalanceModel = (*customBalanceModel)(nil)

type (
	// BalanceModel is an interface to be customized, add more methods here,
	// and implement the added methods in customBalanceModel.
	BalanceModel interface {
		balanceModel
	}

	customBalanceModel struct {
		*defaultBalanceModel
	}
)

// NewBalanceModel returns a model for the mongo.
func NewBalanceModel(url, db, collection string) BalanceModel {
	conn := mon.MustNewModel(url, db, collection)
	return &customBalanceModel{
		defaultBalanceModel: newDefaultBalanceModel(conn),
	}
}
