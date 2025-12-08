terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_iam_user" "this" {
  name = var.username
  tags = var.tags
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}
