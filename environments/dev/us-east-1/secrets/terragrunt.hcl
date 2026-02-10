# Secrets Manager configuration for Dev environment

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../env.hcl"
  expose = true
}

terraform {
  source = "../../../../modules/secrets-manager"
}

inputs = {
  project     = "gearify"
  environment = include.env.locals.environment

  # These will use placeholder values initially
  # Update them manually in AWS Secrets Manager or via CI/CD
  stripe_api_key         = ""
  stripe_webhook_secret  = ""
  stripe_publishable_key = ""
  paypal_client_id       = ""
  paypal_client_secret   = ""
  smtp_host              = ""
  smtp_username          = ""
  smtp_password          = ""
  smtp_from_address      = "noreply@gearify-dev.com"
  opensearch_endpoint    = ""
  opensearch_username    = "admin"
  opensearch_password    = ""
}
