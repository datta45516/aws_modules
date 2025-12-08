
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_sqs_queue" "this" {
  name                      = var.queue_name
  visibility_timeout_seconds = 30
  message_retention_seconds = 345600
  tags                      = var.tags
}
