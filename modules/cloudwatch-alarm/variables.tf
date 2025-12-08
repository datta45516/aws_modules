variable "region" { default = "us-east-1" }
variable "alarm_name" { type = string }
variable "metric_name" { type = string }
variable "namespace" { type = string }
variable "threshold" { type = number }
variable "sns_topic_arns" { type = list(string) default = [] }
