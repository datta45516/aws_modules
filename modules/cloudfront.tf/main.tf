
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = "us-east-1" }  # CloudFront is global

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object
  origin {
    domain_name = var.origin_domain
    origin_id   = "S3Origin"
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions { geo_restriction { restriction_type = "none" } }
  tags = var.tags
}
