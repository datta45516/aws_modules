output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "s3_bucket_name" {
  description = "Main bucket"
  value       = module.s3_bucket.bucket_name
}

output "alb_dns_name" {
  description = "ALB DNS"
  value       = module.alb.alb_dns_name
}
