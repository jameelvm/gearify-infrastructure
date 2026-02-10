# DynamoDB configuration for Dev environment

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../env.hcl"
  expose = true
}

terraform {
  source = "../../../../modules/dynamodb"
}

inputs = {
  project                = "gearify"
  environment            = include.env.locals.environment
  billing_mode           = "PAY_PER_REQUEST"
  point_in_time_recovery = include.env.locals.point_in_time_recovery
}
