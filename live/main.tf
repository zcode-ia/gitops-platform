locals {
  vpc_config = jsondecode(file("${path.module}/vpc.json"))
}

# Iterate over each VPC configuration in the JSON file
module "vpc" {
  for_each = local.vpc_config

  source = "../modules/vpc"

  vpc_cidr_block                         = each.value.vpc_cidr_block
  vpc_enable_dns_support                 = each.value.vpc_enable_dns_support
  vpc_enable_dns_hostnames               = each.value.vpc_enable_dns_hostnames
  vpc_tags                               = each.value.vpc_tags
  igw_tags                               = each.value.igw_tags
  nat_gateway_tags                       = each.value.nat_gateway_tags
  eip_private_ip                         = each.value.eip_private_ip
  eip_tags                               = each.value.eip_tags
  public_route_cidr_block                = each.value.public_route_cidr_block
  public_route_table_tags                = each.value.public_route_table_tags
  private_route_cidr_block               = each.value.private_route_cidr_block
  private_route_table_tags               = each.value.private_route_table_tags
  public_subnets                         = each.value.public_subnets
  private_subnets                        = each.value.private_subnets
  flow_log_tags                          = each.value.flow_log_tags
  cloudwatch_log_group_tags              = each.value.cloudwatch_log_group_tags
  flow_log_role_name                     = each.value.flow_log_role_name
  flow_log_policy_name                   = each.value.flow_log_policy_name
  cloudwatch_log_group_retention_in_days = each.value.cloudwatch_log_group_retention_in_days
}
