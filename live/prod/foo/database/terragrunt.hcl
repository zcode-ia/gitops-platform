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
  path = "${get_repo_root()}/live/_env/aws.hcl"

  # To reference the variables from the included config.
  expose = true
}

# Configure the module to use in this environment.
terraform {
  source = "${get_repo_root()}/modules/vpc"
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this environment.
# ---------------------------------------------------------------------------------------------------------------------

locals {
  inputs_from_json = jsondecode(file("${get_terragrunt_dir()}/vpc.json"))
  env_vars         = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  vpc_cidr_block           = local.inputs_from_json.vpc_cidr_block
  vpc_enable_dns_support   = local.inputs_from_json.vpc_enable_dns_support
  vpc_enable_dns_hostnames = local.inputs_from_json.vpc_enable_dns_hostnames
  vpc_tags = merge(
    local.inputs_from_json.vpc_tags,
    include.aws.locals.tags,
    local.env_vars.locals.tags
  ),
  igw_tags = merge(
    local.inputs_from_json.igw_tags,
    include.aws.locals.tags,
    local.env_vars.locals.tags
  ),
  nat_gateway_tags = merge(
    local.inputs_from_json.nat_gateway_tags,
    include.aws.locals.tags,
    local.env_vars.locals.tags
  ),
  eip_private_ip                         = local.inputs_from_json.eip_private_ip
  eip_tags                               = local.inputs_from_json.eip_tags
  public_route_cidr_block                = local.inputs_from_json.public_route_cidr_block
  public_route_table_tags                = local.inputs_from_json.public_route_table_tags
  private_route_cidr_block               = local.inputs_from_json.private_route_cidr_block
  private_route_table_tags               = local.inputs_from_json.private_route_table_tags
  public_subnets                         = local.inputs_from_json.public_subnets
  private_subnets                        = local.inputs_from_json.private_subnets
  flow_log_tags                          = lookup(local.inputs_from_json, "flow_log_tags", {})
  cloudwatch_log_group_tags              = lookup(local.inputs_from_json, "cloudwatch_log_group_tags", {})
  flow_log_role_name                     = lookup(local.inputs_from_json, "flow_log_role_name", null)
  flow_log_policy_name                   = lookup(local.inputs_from_json, "flow_log_policy_name", null)
  cloudwatch_log_group_retention_in_days = lookup(local.inputs_from_json, "cloudwatch_log_group_retention_in_days", 0)
  enable_flow_logs                       = lookup(local.inputs_from_json, "enable_flow_logs", false)
}
