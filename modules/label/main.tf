terraform { required_providers { aws = {} } }

output "tags" {
  value = merge(
    { Name = var.name },
    { Environment = var.environment },
    var.additional_tags
  )
}
