
locals {
  connector_base_config = {
    "connector.class"          = var.connector.class
    "name"                     = var.connector.name
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = var.service_account.id
    "kafka.topic"              = var.connector.topic
    "tasks.max"                = var.connector.tasks
  }
  connector_config = merge(
    local.connector_base_config,
    var.connector.config_nonsensitive
  )
}


data "confluent_kafka_cluster" "cluster" {
  id = var.cluster
  environment {
    id = var.environment
  }
}

resource "confluent_kafka_acl" "app-connector-describe-on-cluster" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  resource_type = "CLUSTER"
  resource_name = "kafka-cluster"
  pattern_type  = "LITERAL"
  principal     = "User:${var.service_account.id}"
  host          = "*"
  operation     = "DESCRIBE"
  permission    = "ALLOW"
  rest_endpoint = data.confluent_kafka_cluster.cluster.rest_endpoint
  credentials {
    key    = var.service_account.key
    secret = var.service_account.secret
  }
}

resource "confluent_kafka_acl" "app-connector-write-on-target-topic" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  resource_type = "TOPIC"
  resource_name = var.connector.topic
  pattern_type  = "LITERAL"
  principal     = "User:${var.service_account.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = data.confluent_kafka_cluster.cluster.rest_endpoint
  credentials {
    key    = var.service_account.key
    secret = var.service_account.secret
  }
}

resource "confluent_kafka_acl" "app-connector-create-on-data-preview-topics" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  resource_type = "TOPIC"
  resource_name = var.connector.topic
  pattern_type  = "LITERAL"
  principal     = "User:${var.service_account.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = data.confluent_kafka_cluster.cluster.rest_endpoint
  credentials {
    key    = var.service_account.key
    secret = var.service_account.secret
  }
}

resource "confluent_kafka_acl" "app-connector-write-on-data-preview-topics" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  resource_type = "TOPIC"
  resource_name = var.connector.topic
  pattern_type  = "LITERAL"
  principal     = "User:${var.service_account.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = data.confluent_kafka_cluster.cluster.rest_endpoint
  credentials {
    key    = var.service_account.key
    secret = var.service_account.secret
  }
}


resource "confluent_connector" "connector" {
  environment {
    id = var.environment
  }
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  config_sensitive    = var.connector.config_sensitive
  config_nonsensitive = local.connector_config
}
