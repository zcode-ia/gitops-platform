<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.91.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.91.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Retention period for the CloudWatch log group in days. | `number` | `0` | no |
| <a name="input_cloudwatch_log_group_tags"></a> [cloudwatch\_log\_group\_tags](#input\_cloudwatch\_log\_group\_tags) | Tags to assign to the CloudWatch log group. | `map(string)` | `{}` | no |
| <a name="input_eip_private_ip"></a> [eip\_private\_ip](#input\_eip\_private\_ip) | The private IP address to associate with the EIP | `string` | n/a | yes |
| <a name="input_eip_tags"></a> [eip\_tags](#input\_eip\_tags) | Tags for the EIP | `map(string)` | n/a | yes |
| <a name="input_enable_flow_logs"></a> [enable\_flow\_logs](#input\_enable\_flow\_logs) | Enable VPC Flow Logs. | `bool` | `false` | no |
| <a name="input_flow_log_policy_name"></a> [flow\_log\_policy\_name](#input\_flow\_log\_policy\_name) | Name of the IAM policy for flow logs. | `string` | `null` | no |
| <a name="input_flow_log_role_name"></a> [flow\_log\_role\_name](#input\_flow\_log\_role\_name) | Name of the IAM role for flow logs. | `string` | `null` | no |
| <a name="input_flow_log_tags"></a> [flow\_log\_tags](#input\_flow\_log\_tags) | Tags to assign to the flow logs. | `map(string)` | `{}` | no |
| <a name="input_igw_tags"></a> [igw\_tags](#input\_igw\_tags) | Tags for the Internet Gateway | `map(string)` | n/a | yes |
| <a name="input_nat_gateway_tags"></a> [nat\_gateway\_tags](#input\_nat\_gateway\_tags) | Tags for the NAT Gateway | `map(string)` | n/a | yes |
| <a name="input_private_route_cidr_block"></a> [private\_route\_cidr\_block](#input\_private\_route\_cidr\_block) | CIDR block for the private route | `string` | n/a | yes |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | Tags for the private route table | `map(string)` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets with their settings | <pre>list(object({<br/>    cidr_block              = string<br/>    availability_zone       = string<br/>    map_public_ip_on_launch = bool<br/>    tags                    = map(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_public_route_cidr_block"></a> [public\_route\_cidr\_block](#input\_public\_route\_cidr\_block) | CIDR block for the public route | `string` | n/a | yes |
| <a name="input_public_route_table_tags"></a> [public\_route\_table\_tags](#input\_public\_route\_table\_tags) | Tags for the public route table | `map(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnets with their settings | <pre>list(object({<br/>    cidr_block              = string<br/>    availability_zone       = string<br/>    map_public_ip_on_launch = bool<br/>    tags                    = map(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#input\_vpc\_enable\_dns\_hostnames) | A boolean flag to enable/disable DNS hostnames in the VPC | `bool` | n/a | yes |
| <a name="input_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#input\_vpc\_enable\_dns\_support) | A boolean flag to enable/disable DNS support in the VPC | `bool` | n/a | yes |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | The tags for the VPC | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
