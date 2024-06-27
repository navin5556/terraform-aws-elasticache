resource "aws_elasticache_replication_group" "redis" {
  replication_group_id        = var.replication_group_id
  description                 = var.description
  engine                      = "redis"
  engine_version              = var.engine_version
  node_type                   = var.node_type
  num_cache_clusters          = var.num_cache_clusters
  parameter_group_name        = var.parameter_group_name
  port                        = var.port
  subnet_group_name           = var.subnet_group_name
  security_group_ids          = var.security_group_ids
  multi_az_enabled            = var.multi_az_enabled
  preferred_cache_cluster_azs = var.preferred_cache_cluster_azs
  maintenance_window          = var.maintenance_window
  snapshot_retention_limit    = var.snapshot_retention_limit
  snapshot_window             = var.snapshot_window
  automatic_failover_enabled  = var.automatic_failover_enabled
  at_rest_encryption_enabled  = var.at_rest_encryption_enabled

  log_delivery_configuration {
    destination      = var.slow_log_destination
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }

  log_delivery_configuration {
    destination      = var.engine_log_destination
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "engine-log"
  }

  tags = var.tags
}
