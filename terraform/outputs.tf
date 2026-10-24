output "application_url" {
  description = "Application URL using ALB DNS; HTTP because no domain is configured"
  value       = "http://${aws_lb.app.dns_name}"
}

output "health_check_url" {
  value = "http://${aws_lb.app.dns_name}/health.html"
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.address
}

output "app_bucket_name" {
  value = aws_s3_bucket.app.bucket
}

output "alb_log_bucket_name" {
  value = aws_s3_bucket.alb_logs.bucket
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}
