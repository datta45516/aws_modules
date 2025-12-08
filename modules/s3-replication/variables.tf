variable "region" { default = "us-east-1" }
variable "source_bucket" { type = string }
variable "destination_bucket_arn" { type = string }
variable "replication_role_arn" { type = string }
