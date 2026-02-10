# Secrets Manager Module Variables

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

# Stripe variables (optional - can be set later)
variable "stripe_api_key" {
  description = "Stripe API key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "stripe_webhook_secret" {
  description = "Stripe webhook secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "stripe_publishable_key" {
  description = "Stripe publishable key"
  type        = string
  default     = ""
  sensitive   = true
}

# PayPal variables (optional - can be set later)
variable "paypal_client_id" {
  description = "PayPal client ID"
  type        = string
  default     = ""
  sensitive   = true
}

variable "paypal_client_secret" {
  description = "PayPal client secret"
  type        = string
  default     = ""
  sensitive   = true
}

# SMTP variables (optional - can be set later)
variable "smtp_host" {
  description = "SMTP server host"
  type        = string
  default     = ""
}

variable "smtp_username" {
  description = "SMTP username"
  type        = string
  default     = ""
  sensitive   = true
}

variable "smtp_password" {
  description = "SMTP password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "smtp_from_address" {
  description = "Default from email address"
  type        = string
  default     = ""
}

# OpenSearch variables
variable "opensearch_endpoint" {
  description = "OpenSearch endpoint URL"
  type        = string
  default     = ""
}

variable "opensearch_username" {
  description = "OpenSearch master username"
  type        = string
  default     = "admin"
}

variable "opensearch_password" {
  description = "OpenSearch master password"
  type        = string
  default     = ""
  sensitive   = true
}
