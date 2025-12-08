
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_neptune_cluster" "this" {
  cluster_identifier  = var.name
  engine              = "neptune"
  skip_final_snapshot = true
  iam_database_authentication_enabled = true
  neptune_subnet_group_name = aws_neptune_subnet_group.this.name
}

resource "aws_neptune_cluster_instance" "this" {
  count              = 1
  cluster_identifier = aws_neptune_cluster.this.id
  instance_class     = "db.t3.medium"
}

resource "aws_neptune_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
}
