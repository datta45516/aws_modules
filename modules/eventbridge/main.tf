terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_cloudwatch_event_rule" "this" {
  name        = var.rule_name
  schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "LambdaTarget"
  arn       = var.lambda_arn
}
