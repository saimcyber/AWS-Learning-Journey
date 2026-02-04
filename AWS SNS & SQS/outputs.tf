output "sns_topic_arn" {
  value = aws_sns_topic.main_topic.arn
}

output "orders_queue_url" {
  value = aws_sqs_queue.orders_queue.id
}

output "billing_queue_url" {
  value = aws_sqs_queue.billing_queue.id
}

output "analytics_queue_url" {
  value = aws_sqs_queue.analytics_queue.id
}

output "dlq_queue_url" {
  value = aws_sqs_queue.dlq.id
}
