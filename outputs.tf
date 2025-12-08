output "vpc_id"                  { value = module.vpc.vpc_id }
output "eks_cluster_endpoint"     { value = module.eks.cluster_endpoint }
output "s3_bucket_name"           { value = module.s3_bucket.bucket_name }
output "alb_dns_name"             { value = module.alb.alb_dns_name }
output "lambda_function_arn"       { value = module.lambda.function_arn }
output "rds_endpoint"             { value = module.rds.endpoint }
output "cloudfront_domain"        { value = module.cloudfront.domain_name }
output "all_outputs" {
  value = {
    vpc_id           = module.vpc.vpc_id
    eks_endpoint     = module.eks.cluster_endpoint
    s3_bucket        = module.s3_bucket.bucket_name
    alb_dns          = module.alb.alb_dns_name
    # add more as needed
  }
}
