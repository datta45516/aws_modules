terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_dx_gateway" "this" {
  name            = var.name
  amazon_side_asn = "64512"
}
