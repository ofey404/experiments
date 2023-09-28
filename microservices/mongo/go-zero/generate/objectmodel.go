package generate

import "github.com/zeromicro/go-zero/core/stores/mon"

var _ ObjectModel = (*customObjectModel)(nil)

type (
	// ObjectModel is an interface to be customized, add more methods here,
	// and implement the added methods in customObjectModel.
	ObjectModel interface {
		objectModel
	}

	customObjectModel struct {
		*defaultObjectModel
	}
)

// NewObjectModel returns a model for the mongo.
func NewObjectModel(url, db, collection string) ObjectModel {
	conn := mon.MustNewModel(url, db, collection)
	return &customObjectModel{
		defaultObjectModel: newDefaultObjectModel(conn),
	}
}
