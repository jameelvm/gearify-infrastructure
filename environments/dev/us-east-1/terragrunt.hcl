# Dev US-East-1 Region Terragrunt Configuration

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Include the root terragrunt.hcl configuration
include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

# Generate a region.hcl file
generate "region" {
  path      = "region.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "aws_region" {
  default = "${local.env_vars.locals.aws_region}"
}
EOF
}
