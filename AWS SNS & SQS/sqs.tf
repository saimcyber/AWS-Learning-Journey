########################
# Dead Letter Queue
########################
resource "aws_sqs_queue" "dlq" {
  name = "phase6-sqs-dlq"
}

########################
# Orders Queue
########################
resource "aws_sqs_queue" "orders_queue" {
  name = "phase6-sqs-orders"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
}

########################
# Billing Queue
########################
resource "aws_sqs_queue" "billing_queue" {
  name = "phase6-sqs-billing"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
}

########################
# Analytics Queue
########################
resource "aws_sqs_queue" "analytics_queue" {
  name = "phase6-sqs-analytics"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
}

########################
# Queue Policies (SNS → SQS)
########################

resource "aws_sqs_queue_policy" "orders_policy" {
  queue_url = aws_sqs_queue.orders_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "sns.amazonaws.com" }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.orders_queue.arn
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.main_topic.arn
        }
      }
    }]
  })
}

resource "aws_sqs_queue_policy" "billing_policy" {
  queue_url = aws_sqs_queue.billing_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "sns.amazonaws.com" }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.billing_queue.arn
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.main_topic.arn
        }
      }
    }]
  })
}

resource "aws_sqs_queue_policy" "analytics_policy" {
  queue_url = aws_sqs_queue.analytics_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "sns.amazonaws.com" }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.analytics_queue.arn
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.main_topic.arn
        }
      }
    }]
  })
}
