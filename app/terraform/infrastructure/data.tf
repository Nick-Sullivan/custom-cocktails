
data "aws_ssm_parameter" "api_gateway_url" {
  name = "${local.prefix_parameter}/ApiGateway/Url"
}
