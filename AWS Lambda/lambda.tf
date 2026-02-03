data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda.zip"
}
data "archive_file" "scheduled_lambda_zip" {
  type        = "zip"
  source_file = "scheduled_lambda.py"
  output_path = "scheduled_lambda.zip"
}
data "archive_file" "api_lambda_zip" {
  type        = "zip"
  source_file = "api_lambda.py"
  output_path = "api_lambda.zip"
}

resource "aws_lambda_function" "api_lambda" {
  function_name = "phase6_api_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "api_lambda.lambda_handler"
  runtime       = "python3.10"

  filename         = data.archive_file.api_lambda_zip.output_path
  source_code_hash = data.archive_file.api_lambda_zip.output_base64sha256
}

resource "aws_lambda_function" "scheduled_lambda" {
  function_name = "phase6_scheduled_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "scheduled_lambda.lambda_handler"
  runtime       = "python3.10"

  filename         = data.archive_file.scheduled_lambda_zip.output_path
  source_code_hash = data.archive_file.scheduled_lambda_zip.output_base64sha256
}


resource "aws_lambda_function" "s3_processor" {
  function_name = "phase6_s3_file_processor"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.file_bucket.arn
}

resource "aws_api_gateway_rest_api" "api" {
  name = "phase6_serverless_api"
}
resource "aws_api_gateway_resource" "hello" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "hello"
}
resource "aws_api_gateway_method" "get_hello" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.hello.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.get_hello.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api_lambda.invoke_arn
}
resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]
}
resource "aws_api_gateway_stage" "stage" {
  stage_name    = "prod"
  rest_api_id  = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.file_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}


resource "aws_cloudwatch_event_rule" "schedule_rule" {
  name                = "phase6_scheduled_rule"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.schedule_rule.name
  target_id = "ScheduledLambda"
  arn       = aws_lambda_function.scheduled_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.scheduled_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule_rule.arn
}
