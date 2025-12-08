terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_ssm_parameter" "this" {
  name  = var.parameter_name
  type  = "SecureString"
  value = var.parameter_value
  tags  = var.tags
}
