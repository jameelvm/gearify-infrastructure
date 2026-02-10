# Root Terragrunt configuration for Gearify Infrastructure
# This file contains common configuration shared across all environments

locals {
  # Parse the file path to extract environment and region
  parsed = regex(".*/environments/(?P<env>[^/]+)/(?P<region>[^/]+)/.*", get_terragrunt_dir())
  env    = local.parsed.env
  region = local.parsed.region

  # Common tags applied to all resources
  common_tags = {
    Project     = "gearify"
    ManagedBy   = "terragrunt"
    Repository  = "gearify-infrastructure"
  }
}

# Configure Terragrunt to automatically store state files in S3
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "gearify-terraform-state-${get_aws_account_id()}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gearify-terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

provider "aws" {
  region = "${local.region}"

  default_tags {
    tags = ${jsonencode(local.common_tags)}
  }
}
EOF
}

# Configure root-level inputs
inputs = {
  aws_region  = local.region
  environment = local.env
  project     = "gearify"
}
