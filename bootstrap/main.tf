provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "github_repository" {
  description = "GitHub OWNER/REPOSITORY, exact case"
  type        = string
}

resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-terraform-assessment"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          "token.actions.githubusercontent.com:sub" = "repo:${var.github_repository}:environment:assessment"
        }
      }
    }]
  })
}

# Practical bootstrap permission: broad and temporary.
# Before final submission, replace this with a reviewed custom policy
# restricted to this project's required actions and resources.
resource "aws_iam_role_policy_attachment" "temporary_poweruser" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role_policy" "iam_passrole" {
  name = "assessment-pass-ec2-role"
  role = aws_iam_role.github_actions.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["iam:PassRole"]
      Resource = "arn:aws:iam::*:role/aws-devops-assessment-dev-ec2-role"
    }]
  })
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}
