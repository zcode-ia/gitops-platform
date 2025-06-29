# -------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform and OpenTofu that helps keep your code DRY and maintainable: https://github.com/gruntwork-io/terragrunt
# -------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Include the aws provider configuration.
include "aws" {
  path = "${get_repo_root()}/live/_env/aws_dev.hcl"

  # To reference the variables from the included config.
  expose = true
}

# Configure the module to use in this environment.
terraform {
  source = "${get_repo_root()}/modules/vpc"
}

# Load the JSON file containing the inputs for the module and merge tags at runtime.
inputs = {
  for key, value in jsondecode(templatefile("${get_terragrunt_dir()}/data.json", {
    environment_alias = include.aws.locals.environment_alias
    aws_region        = include.aws.locals.aws_region
  })) :
  key => endswith(key, "_tags") ? merge(include.aws.locals.tags, value) : value
}
