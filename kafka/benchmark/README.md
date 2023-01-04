# benchmark

I start from [Go社区主流Kafka客户端简要对比](https://tonybai.com/2022/03/28/the-comparison-of-the-go-community-leading-kakfa-clients/)

This blogpost aims "write log to Kafka" as its scenario.

# Candidates

There are 3 common golang kafka clients, they are all tested by production:

1. [Shopify/sarama](https://github.com/Shopify/sarama)
2. [segmentio/kafka-go](https://github.com/segmentio/kafka-go)
3. [confluentinc/confluent-kafka-go](https://github.com/confluentinc/confluent-kafka-go/)
   - By Kafka's company

# Benchmark result (230104, my own PC)

[producer_test.go](producer_test.go) benchmarks producer performance.

# Analysis

We can choose between sarama or kafka-go:

1. sarama: It's more popular.
2. kafka-go: It has developer friendly interface, and more docs.

|                           | sarama        | kafka-go            | confluent             |
|---------------------------|---------------|---------------------|-----------------------|
| async produce performance | 2 (1236ns/op) | 1 (959ns/op)        | 3 (1581ns/op)         |
| memory                    | 1             | 2                   | 3                     |
| stars                     | 9k            | 5k                  | 3k                    |
| testing                   | mock          | docker              | ?                     |
| potential problem         |               | slow sync operation | requires CGO_ENABLED  |


