
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = var.tags
}
