output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "s3_bucket_name" {
  description = "Main S3 bucket name"
  value       = module.s3_bucket.bucket_name
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.alb.alb_dns_name
}

output "lambda_function_arn" {
  description = "Hello Lambda function ARN"
  value       = module.lambda.function_arn
}

output "rds_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = module.rds.endpoint
}

output "cloudfront_domain" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.domain_name
}
