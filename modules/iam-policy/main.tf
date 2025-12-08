terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_iam_policy" "this" {
  name   = var.policy_name
  policy = var.policy_document
}
