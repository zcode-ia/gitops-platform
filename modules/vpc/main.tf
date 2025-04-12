resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags                 = var.vpc_tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = var.igw_tags
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public["public-subnet-1"].id
  tags          = var.nat_gateway_tags
}

resource "aws_eip" "this" {
  associate_with_private_ip = var.eip_private_ip
  tags                      = var.eip_tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.this.id
  }
  tags = var.public_route_table_tags
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = var.private_route_cidr_block
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = var.private_route_table_tags
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_subnet" "public" {
  for_each                = tomap({ for idx, subnet in var.public_subnets : "public-subnet-${idx + 1}" => subnet })
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags                    = each.value.tags
}

resource "aws_subnet" "private" {
  for_each                = tomap({ for idx, subnet in var.private_subnets : "private-subnet-${idx + 1}" => subnet })
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags                    = each.value.tags
}

resource "aws_iam_role" "this" {
  count = var.enable_flow_logs ? 1 : 0
  name  = var.flow_log_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "this" {
  count = var.enable_flow_logs ? 1 : 0
  name  = var.flow_log_policy_name
  role  = aws_iam_role.this[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_flow_log" "this" {
  count                = var.enable_flow_logs ? 1 : 0
  log_destination      = aws_cloudwatch_log_group.this[0].arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this.id
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = aws_iam_role.this[0].arn
  tags                 = var.flow_log_tags
}

#trivy:ignore:AVD-AWS-0017
resource "aws_cloudwatch_log_group" "this" {
  count             = var.enable_flow_logs ? 1 : 0
  name              = "/aws/vpc/flow-logs/${aws_vpc.this.id}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags              = var.cloudwatch_log_group_tags
}
