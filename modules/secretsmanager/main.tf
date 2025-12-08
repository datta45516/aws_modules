
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}
