FROM confluentinc/cp-kafka:latest

# Expose Kafka and Zookeeper ports
EXPOSE 9092 2181

# Environment variables required for Kafka
ENV KAFKA_BROKER_ID=1
ENV KAFKA_ZOOKEEPER_CONNECT=localhost:2181
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092

CMD ["sh", "-c", "/etc/confluent/docker/run"]
