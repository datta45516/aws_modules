terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_ebs_volume" "this" {
  availability_zone = var.az
  size              = var.size_gb
  encrypted         = true
  tags              = var.tags
}
