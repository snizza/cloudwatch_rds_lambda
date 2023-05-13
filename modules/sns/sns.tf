resource "aws_sns_topic" "alarm_notification" {
  name = "RDS-alarm-notification"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notification.arn
  protocol  = "email"
  endpoint  = var.email
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.alarm_notification.arn
  protocol  = "lambda"
  endpoint  = var.lambda_slack_arn
}