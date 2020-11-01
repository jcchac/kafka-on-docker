#!/bin/sh

# Optional ENV variables
#  - KAFKA_ZOOKEEPER_CONNECT: specify Zookeeper connection in the form of `hostname:port`. Defaults to `localhost:2181`

if [ ! -z "$KAFKA_ZOOKEEPER_CONNECT" ]; then
    sed -r -i "s/(zookeeper.connect)=(.*)/\1=$KAFKA_ZOOKEEPER_CONNECT/g" $KAFKA_HOME/config/server.properties
fi

exec "$@"