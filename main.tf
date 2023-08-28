 
data "confluent_environment" "environment" {
  id = var.environment
}

data "confluent_kafka_cluster" "cluster" {
  id = var.cluster
  environment {
    id = var.environment
  }
}

data "confluent_service_account" "manager" {
  display_name = var.service_account
} 

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "${var.service_account}-kafka-api-key"
  description  = "Kafka API Key that is owned by ${var.service_account} service account"
  owner {
    id          = data.confluent_service_account.manager.id
    api_version = data.confluent_service_account.manager.api_version
    kind        = data.confluent_service_account.manager.kind
  } 
  managed_resource {
    id          = data.confluent_kafka_cluster.cluster.id
    api_version = data.confluent_kafka_cluster.cluster.api_version
    kind        = data.confluent_kafka_cluster.cluster.kind

    environment {   
      id = var.environment
    }
  } 
} 

module "connector" {
  source = "./modules/connector"
  providers = {
    confluent = confluent.confluent_cloud
  }
  for_each    = { for connector in var.connectors : connector.name => connector }
  environment = var.environment
  cluster     = var.cluster
  service_account = {
    id = data.confluent_service_account.manager.id
    key = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }
  connector = {
    name                = each.value.name
    class               = each.value.class
    topic               = each.value.topic
    tasks               = each.value.tasks 
    config_sensitive    = each.value.config_sensitive
    config_nonsensitive = each.value.config_nonsensitive
  }
}
