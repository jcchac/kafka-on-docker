FROM openjdk:8-jre-slim

ARG kafka_version
ARG scala_version
ARG kafka_home

# Install Kafka
RUN apt-get update -y \
    && apt-get install -y curl \
    && curl https://apache.brunneis.com/kafka/${kafka_version}/kafka_${scala_version}-${kafka_version}.tgz -o kafka.tgz \
    && tar xfz kafka.tgz -C /opt \
    && ln -s /opt/kafka_${scala_version}-${kafka_version} ${kafka_home} \
    && rm kafka.tgz 

ENV KAFKA_HOME ${kafka_home}
COPY ./entrypoint.sh /usr/bin

ENV PATH "${PATH}:${kafka_home}/bin"