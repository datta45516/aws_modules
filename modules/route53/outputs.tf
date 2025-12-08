
output "zone_id" { value = var.create_zone ? aws_route53_zone.this[0].zone_id : var.zone_id }
