terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_s3_bucket_replication_configuration" "this" {
  bucket = var.source_bucket
  role   = var.replication_role_arn
  rule {
    id     = "replicate-all"
    status = "Enabled"
    destination {
      bucket = var.destination_bucket_arn
    }
  }
}
