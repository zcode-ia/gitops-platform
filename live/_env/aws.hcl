# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform/OpenTofu that provides extra tools for working with multiple modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Generate an AWS provider block.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  access_key = "foo"
  secret_key = "bar"

  endpoints {
    ec2        = "http://localhost:4566" // for vpc deployment
    cloudwatch = "http://localhost:4566" // for cloudwatch deployment
    logs       = "http://localhost:4566" // for logs deployment
    iam        = "http://localhost:4566" // for iam deployment
  }
}
EOF
}
