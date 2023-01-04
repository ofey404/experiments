package main

import (
	"context"
	"fmt"
	kafkago "github.com/segmentio/kafka-go"
)

func main() {
	listTopics()
	//write()
}

func write() {
	w := &kafkago.Writer{
		Addr:     kafkago.TCP("localhost:9092"),
		Topic:    "test",
		Balancer: &kafkago.LeastBytes{},
		Async:    true,
	}

	m := "simple message"
	c := context.Background()
	err := w.WriteMessages(c, kafkago.Message{Value: []byte(m)})

	if err != nil {
		panic(err)
	}
}

func listTopics() {
	conn, err := kafkago.Dial("tcp", "localhost:9092")
	if err != nil {
		panic(err.Error())
	}
	defer conn.Close()

	partitions, err := conn.ReadPartitions()
	if err != nil {
		panic(err.Error())
	}

	m := map[string]struct{}{}

	for _, p := range partitions {
		m[p.Topic] = struct{}{}
	}
	for k := range m {
		fmt.Println(k)
	}
}
