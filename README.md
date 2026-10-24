# AWS DevOps Terraform Assessment

## Overview
A small assessment environment built with Terraform. It provisions a VPC across two Availability Zones, public and private subnets, an internet-facing Application Load Balancer, private EC2 Auto Scaling, private encrypted RDS MySQL, Secrets Manager, S3 application storage, and ALB access logging.

## Important limitations
- The first version uses the ALB-generated DNS name over HTTP because no custom domain is available. A trusted ACM public certificate requires a domain that you control.
- The sample app is a static health-demo page. RDS and Secrets Manager are provisioned as infrastructure components; the sample page does not yet perform database queries.
- Terraform state may contain sensitive values. Use a secured remote backend before enabling CI/CD apply.
- The bootstrap GitHub role includes temporary broad permissions for a practical lab. Replace them with a reviewed least-privilege policy before final submission.
- This project can incur AWS charges, particularly NAT Gateway, ALB and RDS. Destroy resources after the assessment.

## Repository
- `app/`: demo HTML and health endpoint
- `terraform/`: application infrastructure
- `bootstrap/`: GitHub OIDC role setup
- `.github/workflows/`: CI validation workflow

## Prerequisites
- AWS account and permission to create the listed services
- AWS CLI v2, Terraform >= 1.6, Git
- GitHub repository
- PowerShell on Windows, or a Unix shell

## Local setup
1. Configure AWS CLI: `aws configure` (use a dedicated IAM identity; never commit credentials).
2. Verify: `aws sts get-caller-identity`.
3. Copy `terraform/terraform.tfvars.example` to `terraform/terraform.tfvars` only if using local variables; do not commit it.
4. Run `terraform init`, `terraform fmt -check`, `terraform validate`, `terraform plan`.
5. Review every planned resource and expected costs before `terraform apply`.

## Deployment URL
After a successful apply, run `terraform output application_url` and `terraform output health_check_url`.

## Security notes
- EC2 is private; only the ALB security group can reach TCP/80 on EC2.
- RDS is private; only the app security group can reach TCP/3306.
- EC2 uses an instance role for Secrets Manager access.
- S3 buckets block public access and use server-side encryption.
- IMDSv2 is required in the Launch Template.
- Do not commit state files, tfvars, credentials, private keys or passwords.

## Clean up
Run `terraform destroy` from the same working directory/state used to deploy. Confirm the plan carefully. Delete the bootstrap OIDC role/provider only after the main infrastructure is destroyed and the workflow is no longer needed.

## HTTPS
The ALB DNS name is not a domain you control, so ACM cannot issue a trusted public certificate for it. Add a custom domain and ACM validation to complete the company's HTTPS requirement.
