# Dev environment configuration

locals {
  environment = "dev"
  aws_region  = "us-east-1"

  # Dev-specific settings
  vpc_cidr          = "10.0.0.0/16"
  nat_gateway_count = 1

  # EKS settings
  eks_node_instance_types = ["t3.medium"]
  eks_node_desired_size   = 2
  eks_node_min_size       = 2
  eks_node_max_size       = 5

  # RDS settings
  rds_instance_class       = "db.t3.medium"
  rds_multi_az             = false
  rds_deletion_protection  = false
  rds_skip_final_snapshot  = true

  # ElastiCache settings
  redis_node_type           = "cache.t3.micro"
  redis_num_cache_clusters  = 1

  # Feature flags
  enable_performance_insights = false
  point_in_time_recovery      = false
}
