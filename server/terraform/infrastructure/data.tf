data "aws_caller_identity" "identity" {}

data "aws_ssm_parameter" "open_ai_key" {
  name = "${local.prefix_parameter}/Secrets/OpenAiKey"
}
