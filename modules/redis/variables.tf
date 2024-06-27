variable "replication_group_id" {
  description = "The replication group ID"
  type        = string
}

variable "description" {
  description = "The description of the Redis cluster"
  type        = string
}

variable "engine_version" {
  description = "The Redis engine version"
  type        = string
  default     = "7.1"
}

variable "node_type" {
  description = "The instance type of the cache nodes"
  type        = string
  default     = "cache.t3.micro"
}

variable "num_cache_clusters" {
  description = "The number of cache clusters"
  type        = number
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this replication group"
  type        = string
}

variable "port" {
  description = "The port number on which each of the cache nodes will accept connections"
  type        = number
  default     = 6379
}

variable "subnet_group_name" {
  description = "The name of the subnet group to be used for the replication group"
  type        = string
}

variable "security_group_ids" {
  description = "One or more VPC security groups associated with the replication group"
  type        = list(string)
}

variable "multi_az_enabled" {
  description = "Specifies whether the replication group is Multi-AZ enabled"
  type        = bool
  default     = true
}

variable "preferred_cache_cluster_azs" {
  description = "A list of the Availability Zones in which cache nodes will be created"
  type        = list(string)
}

variable "maintenance_window" {
  description = "Specifies the weekly time range for maintenance on the cluster"
  type        = string
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic snapshots before deleting them"
  type        = number
  default     = 3
}

variable "snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster"
  type        = string
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails"
  type        = bool
  default     = true
}

variable "at_rest_encryption_enabled" {
  description = "Specifies whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "slow_log_destination" {
  description = "The CloudWatch log group name for slow logs"
  type        = string
}

variable "engine_log_destination" {
  description = "The CloudWatch log group name for engine logs"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}
