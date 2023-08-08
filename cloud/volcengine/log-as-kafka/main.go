package main

import (
	"context"
	"flag"
	"fmt"

	"github.com/Shopify/sarama"
)

type exampleConsumerGroupHandler struct{}

func (exampleConsumerGroupHandler) Setup(_ sarama.ConsumerGroupSession) error   { return nil }
func (exampleConsumerGroupHandler) Cleanup(_ sarama.ConsumerGroupSession) error { return nil }
func (h exampleConsumerGroupHandler) ConsumeClaim(sess sarama.ConsumerGroupSession, claim sarama.ConsumerGroupClaim) error {
	for msg := range claim.Messages() {
		fmt.Printf("Message topic:%q partition:%d offset:%d message:%s\n", msg.Topic, msg.Partition, msg.Offset, msg.Value)
		sess.MarkMessage(msg, "")
		sess.Commit()
	}
	return nil
}

var (
	projectId = flag.String("projectId", "", "project id")
	ak        = flag.String("ak", "", "access key")
	sk        = flag.String("sk", "", "secret key")
	hosts     = flag.String("hosts", "", "kafka hosts")
	groupId   = flag.String("groupId", "", "kafka groupId")
	topicId   = flag.String("topicId", "", "log topicId")
)

func ExampleConsumerGroup() {
	config := sarama.NewConfig()
	config.Version = sarama.V2_0_0_0 // specify appropriate version
	config.ApiVersionsRequest = true
	config.Consumer.Return.Errors = true
	config.Net.SASL.Mechanism = "PLAIN"
	config.Net.SASL.Version = int16(0)
	config.Net.SASL.Enable = true
	config.Net.TLS.Enable = true
	config.Consumer.Offsets.Initial = sarama.OffsetNewest
	// projectId
	config.Net.SASL.User = *projectId
	// 火山引擎账号的密钥，或具备对应权限的子账号密钥。不支持STS临时安全令牌。
	config.Net.SASL.Password = fmt.Sprintf("%s#%s", *ak, *sk)
	// host为消费的地址，具体见文档
	group, err := sarama.NewConsumerGroup([]string{*hosts}, *groupId, config)
	if err != nil {
		panic(err)
	}
	defer func() { _ = group.Close() }()

	// Track errors
	go func() {
		for err := range group.Errors() {
			fmt.Println("ERROR", err)
		}
	}()

	// Iterate over consumer sessions.
	ctx := context.Background()
	for {
		// ${out-TopicID}为Kafka协议消费主题ID，格式为out+日志主题ID，例如"out-0fdaa6b6-3c9f-424c-8664-fc0d222c****"。
		topics := []string{fmt.Sprintf("out-%s", *topicId)}
		handler := exampleConsumerGroupHandler{}

		// `Consume` should be called inside an infinite loop, when a
		// server-side rebalance happens, the consumer session will need to be
		// recreated to get the new claims
		err := group.Consume(ctx, topics, handler)
		if err != nil {
			panic(err)
		}
	}
}

func main() {
	flag.Parse()
	ExampleConsumerGroup()
}
