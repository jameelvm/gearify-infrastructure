# S3 configuration for Dev environment

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../env.hcl"
  expose = true
}

terraform {
  source = "../../../../modules/s3"
}

inputs = {
  project              = "gearify"
  environment          = include.env.locals.environment
  cors_allowed_origins = ["*"]  # In prod, restrict to specific domains
}
