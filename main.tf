# ==== VPC ====
module "vpc" {
  source          = "./modules/vpc"
  name            = "${var.project_name}-vpc"
  cidr_block      = var.vpc_cidr
  azs             = var.azs
  public_subnets  = [cidrsubnet(var.vpc_cidr, 8, 1), cidrsubnet(var.vpc_cidr, 8, 2)]
  private_subnets = [cidrsubnet(var.vpc_cidr, 8, 10), cidrsubnet(var.vpc_cidr, 8, 11)]
}

# ==== S3 Bucket ====
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

module "s3_bucket" {
  source      = "./modules/s3-bucket"
  bucket_name = "${var.project_name}-main-bucket-${random_string.suffix.result}"
}

# ==== Security Group ====
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

  tags = { Name = "main-sg" }
}

# ==== ACM (must come before ALB) ====
module "acm" {
  source      = "./modules/acm"
  domain_name = "example.com"  # change to your real domain later
}

# ==== ALB ====
module "alb" {
  source             = "./modules/alb"
  name               = var.project_name
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security_group.id]
  vpc_id             = module.vpc.vpc_id
  certificate_arn    = module.acm.certificate_arn
}

# ==== All other modules – clean, no semicolons ====
module "eks" {
  source            = "./modules/eks"
  cluster_name      = "${var.project_name}-eks"
  kubernetes_version = "1.30"
  subnet_ids        = module.vpc.private_subnet_ids
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

module "iam_role" {
  source            = "./modules/iam-role"
  role_name         = "demo-role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  policy_json       = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Effect = "Allow", Action = "s3:*", Resource = "*" }]
  })
}

module "cloudfront" { source = "./modules/cloudfront"; origin_domain = module.s3_bucket.bucket_name }
module "route53" { source = "./modules/route53"; create_zone = false; zone_id = "ZXXXXXXXXXXXXX"; record_name = "test"; record_type = "A"; records = ["1.2.3.4"] }
module "ec2_instance" { source = "./modules/ec2-instance"; name = "bastion"; ami_id = data.aws_ami.amazon_linux.id; subnet_id = module.vpc.public_subnet_ids[0]; security_group_ids = [module.security_group.id] }
module "autoscaling" { source = "./modules/autoscaling"; name = "web-asg"; ami_id = data.aws_ami.amazon_linux.id; subnet_ids = module.vpc.private_subnet_ids }
module "dynamodb_table" { source = "./modules/dynamodb-table"; table_name = "${var.project_name}-table"; hash_key = "id" }
module "ecs" { source = "./modules/ecs"; cluster_name = "${var.project_name}-ecs" }
module "sns" { source = "./modules/sns"; topic_name = "alerts" }
module "sqs" { source = "./modules/sqs"; queue_name = "${var.project_name}-queue" }
module "cloudwatch_log_group" { source = "./modules/cloudwatch-log-group"; log_group_name = "/aws/${var.project_name}" }
module "kms" { source = "./modules/kms"; description = "Root key" }
module "secretsmanager" { source = "./modules/secretsmanager"; secret_name = "/${var.project_name}/db"; secret_string = var.admin_password }
module "efs" { source = "./modules/efs"; name = "shared"; subnet_ids = module.vpc.private_subnet_ids; security_group_ids = [module.security_group.id] }
module "apigateway_v2" { source = "./modules/apigateway-v2"; name = "api"; lambda_invoke_arn = module.lambda.invoke_arn }
module "guardduty" { source = "./modules/guardduty" }
module "waf" { source = "./modules/waf"; name = "global-waf" }
module "rds_aurora" { source = "./modules/rds-aurora"; name = "aurora"; db_name = "app"; username = "admin"; password = var.admin_password; subnet_ids = module.vpc.private_subnet_ids }
module "network_acl" { source = "./modules/network-acl"; vpc_id = module.vpc.vpc_id; subnet_ids = module.vpc.private_subnet_ids }
module "vpn" { source = "./modules/vpn"; vpc_id = module.vpc.vpc_id; customer_ip = "1.1.1.1" }
module "bastion" { source = "./modules/bastion"; ami_id = data.aws_ami.amazon_linux.id; public_subnet_id = module.vpc.public_subnet_ids[0]; vpc_id = module.vpc.vpc_id; key_name = "my-key" }
module "documentdb" { source = "./modules/documentdb"; name = "docdb"; username = "admin"; password = var.admin_password; subnet_ids = module.vpc.private_subnet_ids }
module "neptune" { source = "./modules/neptune"; name = "graph"; subnet_ids = module.vpc.private_subnet_ids }
module "cloudwatch_alarm" { source = "./modules/cloudwatch-alarm"; alarm_name = "high-cpu"; metric_name = "CPUUtilization"; namespace = "AWS/EC2"; threshold = 80 }
module "elb" { source = "./modules/elb"; name = "legacy"; subnet_ids = module.vpc.public_subnet_ids; security_group_ids = [module.security_group.id] }
module "emr" { source = "./modules/emr"; name = "analytics"; service_role_arn = module.iam_role.role_arn }
module "spot_instance" { source = "./modules/spot-instance"; name = "spot"; ami_id = data.aws_ami.amazon_linux.id; instance_type = "t3.medium"; subnet_id = module.vpc.private_subnet_ids[0]; security_group_ids = [module.security_group.id] }
module "fargate" { source = "./modules/fargate"; name = "app"; cluster_id = module.ecs.cluster_id; execution_role_arn = module.iam_role.role_arn; container_definitions = jsonencode([{ name = "hello", image = "amazon/amazon-ecs-sample", essential = true }]) }
module "ssm" { source = "./modules/ssm"; parameter_name = "/db/host"; parameter_value = module.rds.endpoint }
module "ebs_volume" { source = "./modules/ebs-volume"; az = var.azs[0]; size_gb = 100 }
module "direct_connect" { source = "./modules/direct-connect"; name = "dc" }
module "iam_policy" { source = "./modules/iam-policy"; policy_name = "readonly"; policy_document = jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Action="*:Read",Resource="*"}]}) }
module "autoscaling_schedule" { source = "./modules/autoscaling-schedule"; asg_name = module.autoscaling.asg_name; min_size = 1; max_size = 10; desired_capacity = 3 }
module "label" { source = "./modules/label"; name = var.project_name; environment = var.environment }
module "ecs_alb" { source = "./modules/ecs-alb"; name = "ecs"; vpc_id = module.vpc.vpc_id; listener_arn = module.alb.https_listener_arn; priority = 100; path_pattern = "/*" }
module "eventbridge" { source = "./modules/eventbridge"; rule_name = "daily"; schedule = "cron(0 5 * * ? *)"; lambda_arn = module.lambda.function_arn }
module "iam_account" { source = "./modules/iam-account" }
module "eks_nodegroup" { source = "./modules/eks-nodegroup"; cluster_name = module.eks.cluster_name; node_group_name = "main"; node_role_arn = module.iam_role.role_arn; subnet_ids = module.vpc.private_subnet_ids }
module "s3_replication" { source = "./modules/s3-replication"; source_bucket = module.s3_bucket.bucket_name; destination_bucket_arn = "arn:aws:s3:::my-backup-bucket-123"; replication_role_arn = module.iam_role.role_arn }
module "cloudwatch_dashboard" { source = "./modules/cloudwatch-dashboard"; dashboard_name = "${var.project_name}-dash"; dashboard_json = jsonencode({ widgets = [] }) }
module "iam_user" { source = "./modules/iam-user"; username = "terraform-bot" }
module "s3_logging" { source = "./modules/s3-logging"; target_bucket = module.s3_bucket.bucket_name; log_bucket = "${var.project_name}-logs-${random_string.suffix.result}" }

# ==== Data sources ====
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
