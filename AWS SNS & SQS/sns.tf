resource "aws_sns_topic" "main_topic" {
  name = "phase6-sns-topic"
}

resource "aws_sns_topic_subscription" "orders_sub" {
  topic_arn = aws_sns_topic.main_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.orders_queue.arn
}

resource "aws_sns_topic_subscription" "billing_sub" {
  topic_arn = aws_sns_topic.main_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.billing_queue.arn
}

resource "aws_sns_topic_subscription" "analytics_sub" {
  topic_arn = aws_sns_topic.main_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.analytics_queue.arn
}

resource "aws_sns_topic_subscription" "lambda_sub" {
  topic_arn = aws_sns_topic.main_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.sns_lambda.arn
}
