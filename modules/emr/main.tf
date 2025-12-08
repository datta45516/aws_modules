terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_emr_cluster" "this" {
  name          = var.name
  release_label = "emr-6.12.0"
  applications  = ["Spark"]
  master_instance_group {
    instance_type = "m5.xlarge"
  }
  core_instance_group {
    instance_count = 2
    instance_type  = "m5.xlarge"
  }
  service_role = var.service_role_arn
  tags         = var.tags
}
