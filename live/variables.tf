variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
}

variable "vpc_enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
}

variable "vpc_tags" {
  description = "The tags for the VPC"
  type        = map(string)
}

variable "igw_tags" {
  description = "Tags for the Internet Gateway"
  type        = map(string)
}

variable "nat_gateway_tags" {
  description = "Tags for the NAT Gateway"
  type        = map(string)
}

variable "eip_private_ip" {
  description = "The private IP address to associate with the EIP"
  type        = string
}

variable "eip_tags" {
  description = "Tags for the EIP"
  type        = map(string)
}

variable "public_route_cidr_block" {
  description = "CIDR block for the public route"
  type        = string
}

variable "public_route_table_tags" {
  description = "Tags for the public route table"
  type        = map(string)
}

variable "private_route_cidr_block" {
  description = "CIDR block for the private route"
  type        = string
}

variable "private_route_table_tags" {
  description = "Tags for the private route table"
  type        = map(string)
}

variable "public_subnets" {
  description = "List of public subnets with their settings"
  type = list(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
}

variable "private_subnets" {
  description = "List of private subnets with their settings"
  type = list(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
}

variable "flow_log_tags" {
  description = "Tags for the VPC Flow Logs"
  type        = map(string)
}

variable "cloudwatch_log_group_tags" {
  description = "Tags for the CloudWatch Log Group"
  type        = map(string)
}

variable "flow_log_role_name" {
  description = "The name of the IAM role for VPC Flow Logs"
  type        = string
}

variable "flow_log_policy_name" {
  description = "The name of the IAM policy for VPC Flow Logs"
  type        = string
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The retention period for the CloudWatch Log Group in days"
  type        = number
}
