terraform {
  backend "s3" {
    bucket         = "your-unique-terraform-state-bucket-2025"
    key            = "global/aws-platform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
