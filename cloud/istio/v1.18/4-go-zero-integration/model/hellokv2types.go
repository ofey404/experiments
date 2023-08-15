package model

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type HelloKv2 struct {
	ID primitive.ObjectID `bson:"_id,omitempty" json:"id,omitempty"`
	// Fill your own fields
	Key   string `bson:"key,omitempty" json:"key,omitempty"`
	Value string `bson:"value,omitempty" json:"value,omitempty"`
	// END: Fill your own fields
	UpdateAt time.Time `bson:"updateAt,omitempty" json:"updateAt,omitempty"`
	CreateAt time.Time `bson:"createAt,omitempty" json:"createAt,omitempty"`
}
