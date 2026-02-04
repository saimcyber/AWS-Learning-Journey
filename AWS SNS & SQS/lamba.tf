data "archive_file" "sns_lambda_zip" {
  type        = "zip"
  source_file = "sns_lambda.py"
  output_path = "sns_lambda.zip"
}

resource "aws_lambda_function" "sns_lambda" {
  function_name = "phase6_sns_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "sns_lambda.lambda_handler"
  runtime       = "python3.10"

  filename         = data.archive_file.sns_lambda_zip.output_path
  source_code_hash = data.archive_file.sns_lambda_zip.output_base64sha256
}

resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowSNSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sns_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.main_topic.arn
}
