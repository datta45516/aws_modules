module "vpc" {
  source          = "./modules/vpc"
  name            = "${var.project_name}-vpc"
  cidr_block      = var.vpc_cidr
  azs             = var.azs
  public_subnets  = [cidrsubnet(var.vpc_cidr, 4, 1), cidrsubnet(var.vpc_cidr, 4, 2)]
  private_subnets = [cidrsubnet(var.vpc_cidr, 4, 10), cidrsubnet(var.vpc_cidr, 4, 11)]
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

module "s3_bucket" {
  source = "./modules/s3-bucket"
  bucket = "${var.project_name}-bucket-${random_string.suffix.result}"
}

module "security_group" {
  source = "./modules/security-group"
  name   = "main-sg"
  vpc_id = module.vpc.vpc_id
}
