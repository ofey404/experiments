package model

import "github.com/zeromicro/go-zero/core/stores/mon"

var _ BillingRecordModel = (*customBillingRecordModel)(nil)

type (
	// BillingRecordModel is an interface to be customized, add more methods here,
	// and implement the added methods in customBillingRecordModel.
	BillingRecordModel interface {
		billingRecordModel
	}

	customBillingRecordModel struct {
		*defaultBillingRecordModel
	}
)

// NewBillingRecordModel returns a model for the mongo.
func NewBillingRecordModel(url, db, collection string) BillingRecordModel {
	conn := mon.MustNewModel(url, db, collection)
	return &customBillingRecordModel{
		defaultBillingRecordModel: newDefaultBillingRecordModel(conn),
	}
}
