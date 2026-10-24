variable "aws_region" {
  description = "AWS Region for this assessment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "aws-devops-assessment"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type; confirm Free Tier eligibility for your account"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance class; RDS charges apply"
  type        = string
  default     = "db.t3.micro"
}

variable "enable_multi_az_rds" {
  description = "Multi-AZ RDS costs more; enable for the HA assessment"
  type        = bool
  default     = false
}

variable "db_name" {
  type    = string
  default = "devopsdb"
}

variable "db_username" {
  type    = string
  default = "devopsadmin"
}

variable "github_repository" {
  description = "GitHub OWNER/REPOSITORY, for example saurabhsjadhav/aws-devops-terraform-assessment"
  type        = string
  default     = ""
}
