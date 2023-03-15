#!/bin/bash
source "../.env"

HEADER="Content-Type: application/json"
DATA=$( cat << EOF
{
  "name":"XYZCompanySensorData",
  "config":{
    "connector.class":"com.snowflake.kafka.connector.SnowflakeSinkConnector",
    "tasks.max":"8",
    "topics":"topic1,topic2",
    "snowflake.topic2table.map": "topic1:table1,topic2:table2",
    "buffer.count.records":"10000",
    "buffer.flush.time":"60",
    "buffer.size.bytes":"5000000",
    "snowflake.url.name":"myorganization-myaccount.snowflakecomputing.com:443",
    "snowflake.user.name":"jane.smith",
    "snowflake.private.key":"xyz123",
    "snowflake.private.key.passphrase":"jkladu098jfd089adsq4r",
    "snowflake.database.name":"mydb",
    "snowflake.schema.name":"myschema",
    "key.converter":"org.apache.kafka.connect.storage.StringConverter",
    "value.converter":"com.snowflake.kafka.connector.records.SnowflakeAvroConverter",
    "value.converter.schema.registry.url":"http://localhost:8081",
    "value.converter.basic.auth.credentials.source":"USER_INFO",
    "value.converter.basic.auth.user.info":"jane.smith:MyStrongPassword"
  }
}
EOF
)

curl -X POST -H "${HEADER}" --data "${DATA}" http://localhost:8083/connectors
