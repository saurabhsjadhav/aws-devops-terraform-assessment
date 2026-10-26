resource "aws_db_subnet_group" "main" {
  name       = "${local.name}-db-subnets"
  subnet_ids = [for subnet in aws_subnet.db : subnet.id]
  tags       = { Name = "${local.name}-db-subnets" }
}

resource "aws_db_instance" "mysql" {
  identifier = "${local.name}-mysql"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = var.db_instance_class

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db.result
  port     = 3306

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false
  storage_encrypted      = true
  multi_az               = var.enable_multi_az_rds

  backup_retention_period    = 1
  auto_minor_version_upgrade = true

  deletion_protection = false
  skip_final_snapshot = true

  depends_on = [aws_secretsmanager_secret_version.db]

  tags = { Name = "${local.name}-mysql" }
}
