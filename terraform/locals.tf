locals {
  name = "${var.project_name}-${var.environment}"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnets = {
    az1 = { cidr = "10.0.1.0/24", az = local.azs[0] }
    az2 = { cidr = "10.0.2.0/24", az = local.azs[1] }
  }

  app_subnets = {
    az1 = { cidr = "10.0.11.0/24", az = local.azs[0] }
    az2 = { cidr = "10.0.12.0/24", az = local.azs[1] }
  }

  db_subnets = {
    az1 = { cidr = "10.0.21.0/24", az = local.azs[0] }
    az2 = { cidr = "10.0.22.0/24", az = local.azs[1] }
  }
}
