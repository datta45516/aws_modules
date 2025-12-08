
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_vpn_gateway" "this" {
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_customer_gateway" "this" {
  bgp_asn    = 65000
  ip_address = var.customer_ip
  type       = "ipsec.1"
  tags       = var.tags
}

resource "aws_vpn_connection" "this" {
  vpn_gateway_id      = aws_vpn_gateway.this.id
  customer_gateway_id = aws_customer_gateway.this.id
  type                = "ipsec.1"
  tags                = var.tags
}
