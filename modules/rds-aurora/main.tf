
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_rds_cluster" "this" {
  cluster_identifier   = var.name
  engine               = "aurora-postgresql"
  database_name        = var.db_name
  master_username      = var.username
  master_password      = var.password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_rds_cluster_subnet_group.this.name
}

resource "aws_rds_cluster_instance" "this" {
  count              = 1
  identifier         = "${var.name}-instance"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = "db.r6g.large"
  engine             = "aurora-postgresql"
}

resource "aws_rds_cluster_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
}
