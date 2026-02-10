# OpenSearch configuration for Dev environment

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../env.hcl"
  expose = true
}

terraform {
  source = "../../../../modules/opensearch"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id             = "vpc-mock"
    private_subnet_ids = ["subnet-1", "subnet-2", "subnet-3"]
  }
}

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    node_security_group_id = "sg-mock"
  }
}

inputs = {
  project                  = "gearify"
  environment              = include.env.locals.environment
  vpc_id                   = dependency.vpc.outputs.vpc_id
  subnet_ids               = dependency.vpc.outputs.private_subnet_ids
  allowed_security_groups  = [dependency.eks.outputs.node_security_group_id]
  engine_version           = "OpenSearch_2.11"
  instance_type            = "t3.small.search"
  instance_count           = 1
  dedicated_master_enabled = false
  zone_awareness_enabled   = false
  ebs_volume_size          = 20
  master_username          = "admin"
  log_retention_days       = 14
}
