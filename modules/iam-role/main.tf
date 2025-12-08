
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = { source = "hashicorp/aws" version = "~> 5.0" }
  }
}
provider "aws" { region = var.region }

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
  tags               = var.tags
}

resource "aws_iam_policy" "this" {
  count  = var.policy_json != "" ? 1 : 0
  name   = "${var.role_name}-policy"
  policy = var.policy_json
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = var.policy_json != "" ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this[0].arn
}
