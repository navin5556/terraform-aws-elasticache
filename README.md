# terraform-aws-elasticache
Terraform configurations for setting up AWS ElastiCache with custom subnet groups and security groups

Refer this documentation link for detailed information- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group#primary_endpoint_address


## Module Directory Structure
```
terraform-aws-elasticache/
|
├── main.tf
├── variables.tf
└── outputs.tf

```
##steps
```
run terraform init, terraform plan, terraform apply in the root directory of repo.
```
## Inputs

| Name | Description | Type |
|------|-------------|------|
| replication_group_id | The identifier for the replication group. | `string` |
| engine | The name of the cache engine to be used for the cache clusters in this replication group. | `string` |
| engine_version | The version number of the cache engine to be used for the cache clusters in this replication group. | `string` |
| node_type | The compute and memory capacity of the nodes in the node group. | `string` | `"cache.t3.micro"` | no |
| num_cache_clusters | The number of cache clusters (primary and replicas) this replication group will initially have. | `number` |
| parameter_group_name | The name of the parameter group to associate with this replication group. | `string` |
| port | The port number on which each of the cache nodes will accept connections. | `number` |
| subnet_group_name | The name of the subnet group associated with the replication group. | `string` |
| security_group_ids | One or more Amazon VPC security groups associated with this replication group. | `list(string)` |
| multi_az_enabled | Specifies whether Multi-AZ is enabled. | `bool` | `false` | no |
| preferred_cache_cluster_azs | A list of EC2 Availability Zones in which the replication group's cache clusters will be created. | `list(string)` |
| maintenance_window | Specifies the weekly time range during which system maintenance can occur. | `string` |
| snapshot_retention_limit | The number of days for which ElastiCache retains automatic snapshots. | `number` |
| snapshot_window | The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your node group. | `string` |
| automatic_failover_enabled | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. | `bool` |
| at_rest_encryption_enabled | Enable encryption at rest using an AWS managed KMS key by default. | `bool` |
| log_delivery_configuration | Specifies the destination type, log format, and log type for the log delivery configuration. | `object` |
| tags | A mapping of tags to assign to the resource. | `map(string)` |

## Outputs

| Name | Description |
|------|-------------|
| redis_endpoint | this will print the primary_endpoint_address at the end of terraform apply. |
