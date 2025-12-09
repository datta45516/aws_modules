module "vpc" {
  source          = "./modules/vpc"
  name            = "${var.project_name}-vpc"
  cidr_block      = var.vpc_cidr
  azs             = var.azs
  public_subnets  = [cidrsubnet(var.vpc_cidr, 8, 1), cidrsubnet(var.vpc_cidr, 8, 2)]
  private_subnets = [cidrsubnet(var.vpc_cidr, 8, 10), cidrsubnet(var.vpc_cidr, 8, 11)]
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

module "s3_bucket" {
  source  = "./modules/s3-bucket"
  bucket  = "$$ {var.project_name}-main-bucket- $${random_string.suffix.result}"
  tags    = var.tags  # Optional: pass tags if you want
}

module "security_group" {
  source      = "./modules/security-group"
  name        = "main-sg"
  description = "Main security group"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      cidr        = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP"
    },
    {
      cidr        = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS"
    }
  ]
}

module "acm" {
  source      = "./modules/acm"
  domain_name = "example.com"
}

module "alb" {
  source             = "./modules/alb"
  name               = var.project_name
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security_group.id]
  vpc_id             = module.vpc.vpc_id
  certificate_arn    = module.acm.certificate_arn
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = "${var.project_name}-eks"
  kubernetes_version = "1.30"
  subnet_ids         = module.vpc.private_subnet_ids
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = "${var.project_name}-hello"
  runtime       = "nodejs20.x"
  source_code   = "exports.handler = async () => ({ statusCode: 200, body: 'Hello!' });"
}

module "rds" {
  source             = "./modules/rds"
  name               = "${var.project_name}-db"
  username           = "admin"
  password           = var.admin_password
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_group.id]
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
