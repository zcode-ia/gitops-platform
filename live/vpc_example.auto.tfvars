vpc_cidr_block="10.0.0.0/16"
vpc_enable_dns_support=true
vpc_enable_dns_hostnames=true
vpc_tags={
  "Name" = "example-vpc"
}

igw_tags = {
  Name = "example-igw"
}

nat_gateway_tags = {
  Name = "example-nat-gateway"
}

eip_private_ip = "10.0.1.10"
eip_tags = {
  Name = "example-eip"
}

public_route_cidr_block = "0.0.0.0/0"
public_route_table_tags = {
  Name = "public-route-table"
}

private_route_cidr_block = "0.0.0.0/0"
private_route_table_tags = {
  Name = "private-route-table"
}

public_subnets = [
  {
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-1a"
    }
  }
]

private_subnets = [
  {
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "private-subnet-1b"
    }
  },
  {
    cidr_block              = "10.0.3.0/24"
    availability_zone       = "us-east-1c"
    map_public_ip_on_launch = false
    tags = {
      Name = "private-subnet-1c"
    }
  }
]

flow_log_role_name = "flow-log-role"
flow_log_policy_name = "flow-log-policy"
cloudwatch_log_group_retention_in_days = 7

flow_log_tags = {
  Name = "example-flow-log"
}

cloudwatch_log_group_tags = {
  Name = "example-cloudwatch-log-group"
}
