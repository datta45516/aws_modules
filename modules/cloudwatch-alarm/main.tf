terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = 120
  statistic           = "Average"
  threshold           = var.threshold
  alarm_actions       = var.sns_topic_arns
}
