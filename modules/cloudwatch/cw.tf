resource "aws_cloudwatch_metric_alarm" "cw" {
  alarm_name                = var.alarm_name
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = 10
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors RDS cpu utilization"
  alarm_actions             = [var.sns_topic]
  insufficient_data_actions = []
  dimensions = {
    DBInstanceIdentifier = "my-rds-instance"
  }
}