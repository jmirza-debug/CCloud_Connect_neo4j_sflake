#!/bin/bash
source "../.env"

HEADER="Content-Type: application/json"
DATA=$( cat << EOF
{
  "name": "Neo4jSinkConnectorAVRO",
  "config": {
    "topics": "my-topic",
    "connector.class": "streams.kafka.connect.sink.Neo4jSinkConnector",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "errors.retry.timeout": "-1",
    "errors.retry.delay.max.ms": "1000",
    "errors.tolerance": "all",
    "errors.log.enable": true,
    "errors.log.include.messages": true,
    "neo4j.server.uri": "bolt://neo4j:7687",
    "neo4j.authentication.basic.username": "neo4j",
    "neo4j.authentication.basic.password": "password",
    "neo4j.topic.cypher.my-topic": "MERGE (p:Person{name: event.name, surname: event.surname}) MERGE (f:Family{name: event.surname}) MERGE (p)-[:BELONGS_TO]->(f)"
  }
}
EOF
)

curl -X POST -H "${HEADER}" --data "${DATA}" http://localhost:8083/connectors
