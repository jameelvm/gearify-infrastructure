# Secrets Manager Module Outputs

output "jwt_secret_arn" {
  description = "ARN of the JWT secret"
  value       = aws_secretsmanager_secret.jwt.arn
}

output "jwt_secret_name" {
  description = "Name of the JWT secret"
  value       = aws_secretsmanager_secret.jwt.name
}

output "stripe_secret_arn" {
  description = "ARN of the Stripe secret"
  value       = aws_secretsmanager_secret.stripe.arn
}

output "stripe_secret_name" {
  description = "Name of the Stripe secret"
  value       = aws_secretsmanager_secret.stripe.name
}

output "paypal_secret_arn" {
  description = "ARN of the PayPal secret"
  value       = aws_secretsmanager_secret.paypal.arn
}

output "paypal_secret_name" {
  description = "Name of the PayPal secret"
  value       = aws_secretsmanager_secret.paypal.name
}

output "smtp_secret_arn" {
  description = "ARN of the SMTP secret"
  value       = aws_secretsmanager_secret.smtp.arn
}

output "smtp_secret_name" {
  description = "Name of the SMTP secret"
  value       = aws_secretsmanager_secret.smtp.name
}

output "opensearch_secret_arn" {
  description = "ARN of the OpenSearch secret"
  value       = aws_secretsmanager_secret.opensearch.arn
}

output "opensearch_secret_name" {
  description = "Name of the OpenSearch secret"
  value       = aws_secretsmanager_secret.opensearch.name
}

output "all_secret_arns" {
  description = "List of all secret ARNs"
  value = [
    aws_secretsmanager_secret.jwt.arn,
    aws_secretsmanager_secret.stripe.arn,
    aws_secretsmanager_secret.paypal.arn,
    aws_secretsmanager_secret.smtp.arn,
    aws_secretsmanager_secret.opensearch.arn
  ]
}
