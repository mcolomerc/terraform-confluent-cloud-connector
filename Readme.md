# Confluent Cloud Connectors module 

It allows you to create and manage Confluent Cloud Connectors.

 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | >=1.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | 1.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_connector"></a> [connector](#module\_connector) | ./modules/connector | n/a |

## Resources

| Name | Type |
|------|------|
| [confluent_api_key.app-manager-kafka-api-key](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/api_key) | resource |
| [confluent_environment.environment](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.cluster](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/kafka_cluster) | data source |
| [confluent_service_account.manager](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Confluent Cloud Kafka Cluster | `string` | n/a | yes |
| <a name="input_connectors"></a> [connectors](#input\_connectors) | List ogf connectors to be deployed | <pre>list(object({<br>        name              = string<br>        class             = string<br>        topic             = string<br>        tasks             = number <br>        config_sensitive  = optional(map(string))<br>        config_nonsensitive = map(string)<br>    }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Confluent Cloud environment | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service Account | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->