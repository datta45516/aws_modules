terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_docdb_cluster" "this" {
  cluster_identifier  = var.name
  master_username     = var.username
  master_password     = var.password
  skip_final_snapshot = true
  db_subnet_group_name = aws_docdb_subnet_group.this.name
}

resource "aws_docdb_cluster_instance" "this" {
  count              = 1
  identifier         = "${var.name}-instance"
  cluster_identifier = aws_docdb_cluster.this.id
  instance_class     = "db.t3.medium"
}

resource "aws_docdb_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
}
