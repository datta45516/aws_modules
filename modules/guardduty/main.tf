
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_guardduty_detector" "this" {
  enable = true
  tags   = var.tags
}
