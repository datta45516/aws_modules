terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_kms_key" "this" {
  description             = var.description
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = var.tags
}
