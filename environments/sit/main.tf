locals {
  default_mumbai_vpc = "vpc-02ddc0f45bd9cf6bc" # Replace with your VPC ID  of SIT env
  default_mumbai_subnet = ["subnet-0e0fc981bf2b53729","subnet-04e0cee3bb32c362b","subnet-0e55a335d8f4d810b"] # Replace with your subnet IDs of SIT env
  default_mumbai_az = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  
}

module "redis" {
  source = "../../modules/redis"

  replication_group_id        = "redis-cluster-sit-ms"
  description                 = "This redis cluster will be used by SIT MS ."
  engine_version              = "7.1"
  node_type                   = "cache.t3.micro"
  num_cache_clusters          = 3 # Replace with the actual number of nodes
  parameter_group_name        = "default.redis7.cluster.on"
  port                        = 6379
  subnet_group_name           = aws_elasticache_subnet_group.redis_subnet_group-sit.name # You can provide your already created subnet group name also
  security_group_ids          = [aws_security_group.redis_sg.id] # You can provide your already created sg name also
  multi_az_enabled            = true
  preferred_cache_cluster_azs = local.default_mumbai_az
  maintenance_window          = "tue:20:00-tue:21:00"
  snapshot_retention_limit    = 3
  snapshot_window             = "19:00-20:00"
  automatic_failover_enabled  = true
  at_rest_encryption_enabled  = true
  slow_log_destination        = aws_cloudwatch_log_group.redis_slow_log.name   #You can provide already created log group name also
  engine_log_destination      = aws_cloudwatch_log_group.redis_engine_log.name #You can provide already created log group name also
  tags = {
    Name = "redis-cluster-sit-ms",
    Environment = "DEV",
    MS-Environment = "SIT",
    Terraform = "True"
  }
}

resource "aws_cloudwatch_log_group" "redis_slow_log" {
  name              = "redis-cluster-sit-ms-slow-logs"
  retention_in_days = 14 # Adjust retention as needed
}

resource "aws_cloudwatch_log_group" "redis_engine_log" {
  name              = "redis-cluster-sit-ms-engine-logs"
  retention_in_days = 14 # Adjust retention as needed
}

# Create Security Group
resource "aws_security_group" "redis_sg" {
  name        = "redis-cluster-sit-ms-sg"
  description = "Security group for Redis cluster"
  # vpc_id      = local.default_mumbai_vpc # if we do not provide vpc explicitly then it will create in default vpc

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redis-cluster-sit-ms-sg"
  }
}

# Create Subnet Group
resource "aws_elasticache_subnet_group" "redis_subnet_group-sit" {
  name       = "redis-subnet-group-sit"
  subnet_ids = local.default_mumbai_subnet 

  tags = {
    Name = "redis-subnet-group-sit"
  }
}
