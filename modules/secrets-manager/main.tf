# Secrets Manager Module for Gearify
# Creates secrets for JWT, Stripe, and other service configurations

# Generate JWT secret
resource "random_password" "jwt_secret" {
  length  = 64
  special = false
}

# JWT Secret
resource "aws_secretsmanager_secret" "jwt" {
  name        = "gearify/${var.environment}/jwt"
  description = "JWT signing key for ${var.project} ${var.environment}"

  tags = {
    Name        = "gearify/${var.environment}/jwt"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "jwt" {
  secret_id = aws_secretsmanager_secret.jwt.id
  secret_string = jsonencode({
    secret   = random_password.jwt_secret.result
    issuer   = "gearify-auth"
    audience = "gearify-api"
  })
}

# Stripe Secret (placeholder - to be updated manually)
resource "aws_secretsmanager_secret" "stripe" {
  name        = "gearify/${var.environment}/stripe"
  description = "Stripe API keys for ${var.project} ${var.environment}"

  tags = {
    Name        = "gearify/${var.environment}/stripe"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "stripe" {
  secret_id = aws_secretsmanager_secret.stripe.id
  secret_string = jsonencode({
    api_key        = var.stripe_api_key != "" ? var.stripe_api_key : "sk_test_placeholder"
    webhook_secret = var.stripe_webhook_secret != "" ? var.stripe_webhook_secret : "whsec_placeholder"
    publishable_key = var.stripe_publishable_key != "" ? var.stripe_publishable_key : "pk_test_placeholder"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

# PayPal Secret (placeholder - to be updated manually)
resource "aws_secretsmanager_secret" "paypal" {
  name        = "gearify/${var.environment}/paypal"
  description = "PayPal API credentials for ${var.project} ${var.environment}"

  tags = {
    Name        = "gearify/${var.environment}/paypal"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "paypal" {
  secret_id = aws_secretsmanager_secret.paypal.id
  secret_string = jsonencode({
    client_id     = var.paypal_client_id != "" ? var.paypal_client_id : "placeholder"
    client_secret = var.paypal_client_secret != "" ? var.paypal_client_secret : "placeholder"
    mode          = var.environment == "prod" ? "live" : "sandbox"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

# SMTP/Email Secret (for notification service)
resource "aws_secretsmanager_secret" "smtp" {
  name        = "gearify/${var.environment}/smtp"
  description = "SMTP credentials for ${var.project} ${var.environment}"

  tags = {
    Name        = "gearify/${var.environment}/smtp"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "smtp" {
  secret_id = aws_secretsmanager_secret.smtp.id
  secret_string = jsonencode({
    host     = var.smtp_host != "" ? var.smtp_host : "email-smtp.us-east-1.amazonaws.com"
    port     = 587
    username = var.smtp_username != "" ? var.smtp_username : "placeholder"
    password = var.smtp_password != "" ? var.smtp_password : "placeholder"
    from     = var.smtp_from_address != "" ? var.smtp_from_address : "noreply@gearify.com"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

# OpenSearch Secret
resource "aws_secretsmanager_secret" "opensearch" {
  name        = "gearify/${var.environment}/opensearch"
  description = "OpenSearch credentials for ${var.project} ${var.environment}"

  tags = {
    Name        = "gearify/${var.environment}/opensearch"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "opensearch" {
  secret_id = aws_secretsmanager_secret.opensearch.id
  secret_string = jsonencode({
    endpoint = var.opensearch_endpoint
    username = var.opensearch_username
    password = var.opensearch_password
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}
