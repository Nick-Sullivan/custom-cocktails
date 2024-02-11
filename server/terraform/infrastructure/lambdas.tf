
data "archive_file" "layer" {
  type        = "zip"
  source_dir  = "${local.lambda_dir}/layer"
  excludes    = ["__pycache__.py"]
  output_path = "${local.lambda_dir}/zip/layer.zip"
}

data "archive_file" "handler" {
  type        = "zip"
  source_dir  = "${local.lambda_dir}/handler"
  excludes    = ["__pycache__.py"]
  output_path = "${local.lambda_dir}/zip/handler.zip"
}

data "archive_file" "libs" {
  type        = "zip"
  source_dir  = "${local.lambda_dir}/libs"
  excludes    = ["__pycache__.py"]
  output_path = "${local.lambda_dir}/zip/libs.zip"
}

resource "aws_lambda_layer_version" "libs" {
  filename            = data.archive_file.libs.output_path
  layer_name          = "${local.prefix}-Libs"
  compatible_runtimes = ["python3.11"]
  source_code_hash    = data.archive_file.libs.output_base64sha256
}

resource "aws_lambda_layer_version" "layer" {
  filename            = "${local.lambda_dir}/zip/layer.zip"
  layer_name          = "${local.prefix}-Layer"
  compatible_runtimes = ["python3.11"]
  source_code_hash    = data.archive_file.layer.output_base64sha256
}

resource "aws_cloudwatch_log_group" "all" {
  for_each          = local.lambda_names
  name              = "/aws/lambda/${each.value}"
  retention_in_days = 90
}

resource "aws_lambda_function" "invent" {
  filename      = data.archive_file.handler.output_path
  function_name = local.lambda_names["invent"]
  handler       = "invent.invent"
  layers = [
    aws_lambda_layer_version.layer.arn,
    aws_lambda_layer_version.libs.arn,
  ]
  role             = aws_iam_role.invent.arn
  runtime          = "python3.11"
  timeout          = 30
  source_code_hash = data.archive_file.handler.output_base64sha256
  depends_on       = [aws_cloudwatch_log_group.all]
  memory_size = 256
  environment {
    variables = {
      "ENVIRONMENT" : var.environment,
      "OPEN_AI_KEY": data.aws_ssm_parameter.open_ai_key.value,
    }
  }
}

resource "aws_iam_role" "invent" {
  name                = local.lambda_names["invent"]
  description         = "Allows Lambda to invent cocktails"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

resource "aws_lambda_function_event_invoke_config" "invent" {
  function_name                = aws_lambda_function.invent.function_name
  maximum_retry_attempts       = 0
}
