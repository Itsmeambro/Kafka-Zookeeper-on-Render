# FROM confluentinc/cp-kafka:latest

# # Expose Kafka and Zookeeper ports
# EXPOSE 9092 2181

# # Environment variables required for Kafka
# ENV KAFKA_BROKER_ID=1
# ENV KAFKA_ZOOKEEPER_CONNECT=localhost:2181
# ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://0.0.0.0:9092
# ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092

# CMD ["sh", "-c", "/etc/confluent/docker/run"]


FROM confluentinc/cp-kafka:latest

# Expose Kafka and Zookeeper ports
EXPOSE 9092 2181

# Environment variables for Kafka
ENV KAFKA_BROKER_ID=1
ENV KAFKA_ZOOKEEPER_CONNECT=localhost:2181
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092

# Add a health check script for Zookeeper
COPY check-zookeeper.sh /usr/local/bin/check-zookeeper.sh
RUN chmod +x /usr/local/bin/check-zookeeper.sh

CMD ["sh", "-c", "/usr/local/bin/check-zookeeper.sh && /etc/confluent/docker/run"]

