package main

import (
	"context"
	"github.com/zeromicro/go-zero/core/logx"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"time"
)

type MyObject struct {
	ID string `bson:"_id,omitempty" json:"id,omitempty"`

	UpdateAt time.Time `bson:"updateAt,omitempty" json:"updateAt,omitempty"`
	CreateAt time.Time `bson:"createAt,omitempty" json:"createAt,omitempty"`
}

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	client, err := mongo.Connect(ctx, options.Client().ApplyURI("mongodb://root:password@localhost:27027"))
	logx.Must(err)

	defer func() {
		if err = client.Disconnect(ctx); err != nil {
			panic(err)
		}
	}()

	//list, err := client.ListDatabases(context.TODO(), nil)
	//logx.Must(err)
	//
	//fmt.Printf("client.ListDatabases = %+v\n", list)

	//collection := client.Database("testing").Collection("myobject")
}
