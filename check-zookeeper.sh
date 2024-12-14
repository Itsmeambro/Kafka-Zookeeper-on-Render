#!/bin/bash

echo "Waiting for Zookeeper to be ready..."

while ! nc -z localhost 2181; do
  echo "Zookeeper is not ready... waiting 5 seconds"
  sleep 5
done

echo "Zookeeper is up and running!"
