# SNS Topic
resource "aws_sns_topic" "main_topic" {
  name = "phase6-sns-topic"
}

# SNS → Orders Queue
resource "aws_sns_topic_subscription" "orders_sub" {
  topic_arn = aws_sns_topic.main_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.orders_queue.arn
}

# SNS → Billing Queue
resource "aws_sns_topic_subscription" "billing_sub" {
  topic_arn = aws_sns_topic.main_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.billing_queue.arn
}

# SNS → Analytics Queue
resource "aws_sns_topic_subscription" "analytics_sub" {
  topic_arn = aws_sns_topic.main_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.analytics_queue.arn
}
