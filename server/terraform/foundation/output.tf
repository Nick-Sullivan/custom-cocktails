
resource "aws_ssm_parameter" "open_ai_key" {
  name  = "${local.prefix_parameter}/Secrets/OpenAiKey"
  type  = "SecureString"
  value = var.open_ai_key
}
