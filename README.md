# Kafka on Docker

This repository provides a way to run Kafka on Docker for development purposes. 

The docker-compose file sets up two separated services: `kafka` and `zookeeper`. Both services make use of the same image, built from the `Dockerfile` and containing a regular installation of Kafka, that includes Zookeeper. The image is available on [Docker Hub](https://hub.docker.com/repository/docker/jcchac/kafka).

A different approach could be to use an existing image for creating the `zookeeper` container:

#### **`docker-compose.yml`**
``` yml
version: '3.8'

services: 
  zookeeper:
    image: 'zookeeper:3.6.2'
    ports:
      - "2181:2181"
  kafka:
    build: 
      context: .
        args:
          - kafka_version=${KAFKA_VERSION}
          - scala_version=${SCALA_VERSION}
          - kafka_home=${KAFKA_HOME}
    environment:
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
    entrypoint: entrypoint.sh
      ports:
        - "9092:9092"
    command: kafka-server-start.sh ${KAFKA_HOME}/config/server.properties
    depends_on:
      - zookeeper
```

An `entrypoint.sh` is included to set up the Zookeeper connection in the `server.properties` file, and can be updated in the future to provide configuration for both Kafka and Zookeeper services.

### Pre-requisites

- Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- Modify `.env` if necessary 

## Start the Kafka environment

From the directory containing the `docker-compose.yml` file, run the following command:

```
$ docker-compose up -d --build
```

This command will build the image and start all services in detached mode.

## Interacting with Kafka

In order to interact with the created Kafka environment we can take different approaches:

1. Make use of Docker CLI:

        $ docker-compose exec kafka kafka-topics.sh
    
2. Attatch to an interactive shell:

        $ docker-compose exec kafka bash
        >> kafka-topics.sh

## Terminate the Kafka environment

To tear down the Kafka environment, run the following command:

```
$ docker-compose down
```