
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_sns_topic" "this" {
  name = var.topic_name
  tags = var.tags
}

resource "aws_sns_topic_subscription" "this" {
  count     = length(var.subscribers)
  topic_arn = aws_sns_topic.this.arn
  protocol  = var.subscribers[count.index].protocol
  endpoint  = var.subscribers[count.index].endpoint
}
