// List ogf connectors to be deployed
variable "connectors" {
    type = list(object({
        name              = string
        class             = string
        topic             = string
        tasks             = number 
        config_sensitive  = optional(map(string))
        config_nonsensitive = map(string)
    }))
}
 
// Confluent Cloud environment
variable "environment" {
   type = string
}
// Confluent Cloud Kafka Cluster
variable "cluster" {
  type = string
}

// Service Account
variable "service_account" {
  type = string
}

 
