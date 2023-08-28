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
 

variable "environment" {
   type = string
}

variable "cluster" {
  type = string
}

variable "service_account" {
  type = string
}

variable "confluent_cloud_api_key" {
    type = string
}

variable "confluent_cloud_api_secret" {
    type = string
}
