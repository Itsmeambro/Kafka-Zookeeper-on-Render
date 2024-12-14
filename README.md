
# Deploy Kafka + Zookeeper on Render

Steps to Deploy Kafka + Zookeeper on Render
1. **Create the Project Directory**

```
mkdir kafka-zookeeper-render
cd kafka-zookeeper-render
```

2. **Create Dockerfile**

dockerfile
```
FROM confluentinc/cp-kafka:latest

# Expose Kafka and Zookeeper ports
EXPOSE 9092 2181

# Environment variables required for Kafka
ENV KAFKA_BROKER_ID=1
ENV KAFKA_ZOOKEEPER_CONNECT=localhost:2181
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092

CMD ["sh", "-c", "/etc/confluent/docker/run"] 
```
3. **Create .render.yaml This file tells Render how to deploy the container.**
```
services:
  - type: web
    name: kafka-zookeeper
    env: docker
    plan: starter
    dockerfilePath: Dockerfile
    port: 9092
    healthCheckPath: /
```
4. **Push Code to GitHub**

  * Create a repository on GitHub.
  * Add your files and push them.
```
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/your-username/kafka-zookeeper-render.git
git push -u origin main
```
5. **Deploy on Render**

* Go to Render.
* lick New + → Web Service.
* Connect to your GitHub repository.
* Select the kafka-zookeeper-render repo.
* Render will automatically detect the Dockerfile and start building.
* Set the port to 9092 (since that’s Kafka’s port).

6. **Access the Kafka Broker**

You can access Kafka using the Render service URL.
```
PLAINTEXT://your-service-url:9092
```
## Environment Variables for Render
If you want to manage Kafka and Zookeeper configurations dynamically, add the following Environment Variables in Render:

| Key | Value |
|---|---|
| KAFKA_BROKER_ID | 1 |
| KAFKA_ZOOKEEPER_CONNECT | localhost:2181 |
| KAFKA_ADVERTISED_LISTENERS | PLAINTEXT://0.0.0.0:9092 |
| KAFKA_LISTENERS | PLAINTEXT://0.0.0.0:9092 |


You can set these in Render by going to Environment Variables for the service.

## Verification
To verify that Kafka and Zookeeper are running on Render, you can check the logs.

View Logs on Render:

Go to Render Dashboard → Your Service → Logs.
Run Kafka Commands (via local terminal)

List Topics:

bash
Copy code
kafka-topics --list --bootstrap-server your-service-url:9092
Create a Topic:

bash
Copy code
kafka-topics --create --topic my-topic --bootstrap-server your-service-url:9092 --partitions 1 --replication-factor 1
Producer (Send Messages):

bash
Copy code
kafka-console-producer --broker-list your-service-url:9092 --topic my-topic
Consumer (Receive Messages):

bash
Copy code
kafka-console-consumer --bootstrap-server your-service-url:9092 --topic my-topic --from-beginning
