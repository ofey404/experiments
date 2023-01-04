# Kafka

Refer to [Go社区主流Kafka客户端简要对比](https://tonybai.com/2022/03/28/the-comparison-of-the-go-community-leading-kakfa-clients/)

## Manual commands

From [Kafka quick start](https://developer.confluent.io/quickstart/kafka-docker/)

```bash
docker-compose up -d

# Create a topic
docker exec broker \
kafka-topics --bootstrap-server broker:9092 \
--create \
--topic quickstart

# Write message to topic
docker exec --interactive --tty broker \
kafka-console-producer --bootstrap-server broker:9092 \
--topic quickstart

# Read message
docker exec --interactive --tty broker \
kafka-console-consumer --bootstrap-server broker:9092 \
--topic quickstart \
--from-beginning

docker-compose down
```
