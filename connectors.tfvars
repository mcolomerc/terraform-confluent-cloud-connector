
environment = "env-zmz2zd"

cluster = "lkc-v1vm00"

service_account = "mcolomer-sa-man" 

connectors = [
{
    class = "DatagenSource"
    name  = "DatagenSourceConnector_0" 
    topic = "orders"
    tasks = "1"
    config_nonsensitive = {
      "output.data.format" = "AVRO"
      "quickstart"         = "ORDERS"
    }
} 
]
 
 