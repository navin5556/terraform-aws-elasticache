resource "aws_elasticache_replication_group" "redis" {
  replication_group_id        = "redis-cluster-sit-ms"
  description                 = "This redis cluster will be used by microservices."
  engine                      = "redis"
  engine_version              = "7.1"
  node_type                   = "cache.t3.micro"
  num_cache_clusters          = 3 # Replace with the actual number of nodes
  parameter_group_name        = "default.redis7.cluster.on"
  port                        = 6379
  subnet_group_name           = "redisdevfqa-subnet"     # Replace with your actual subnet group name
  security_group_ids          = ["sg-0c4569d2c1ea62eca"] # Replace with your actual security group ID
  multi_az_enabled            = true
  preferred_cache_cluster_azs = ["${var.region}a", "${var.region}b","${var.region}c"] # Replace with your actual availability zone
  maintenance_window          = "tue:20:00-tue:21:00"
  snapshot_retention_limit    = 3
  snapshot_window             = "19:00-20:00"
  automatic_failover_enabled  = true
  at_rest_encryption_enabled  = true # This is using default KMS key, we can use customer managed also
  log_delivery_configuration {
    destination      = "redis-cluster-sit-ms-slow-logs" #provide already created log group name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = "redis-cluster-sit-ms-engine-logs" #provide already created log group name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "engine-log"
  }
  tags = {
    Name = "redis-cluster-sit-ms"
  }
}