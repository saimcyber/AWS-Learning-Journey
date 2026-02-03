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
