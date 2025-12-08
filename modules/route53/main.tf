
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0
  name  = var.zone_name
  tags  = var.tags
}

resource "aws_route53_record" "this" {
  zone_id = var.zone_id != "" ? var.zone_id : aws_route53_zone.this[0].zone_id
  name    = var.record_name
  type    = var.record_type
  ttl     = 300
  records = var.records
}
