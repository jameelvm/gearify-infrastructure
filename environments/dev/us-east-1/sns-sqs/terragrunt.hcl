# SNS/SQS configuration for Dev environment

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../env.hcl"
  expose = true
}

terraform {
  source = "../../../../modules/sns-sqs"
}

inputs = {
  project     = "gearify"
  environment = include.env.locals.environment
  aws_region  = include.env.locals.aws_region
}
