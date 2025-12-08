
terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_launch_template" "this" {
  name          = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = var.user_data
}

resource "aws_autoscaling_group" "this" {
  name                = var.name
  vpc_zone_identifier = var.subnet_ids
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  target_group_arns = var.target_group_arns
  tags = [for k, v in var.tags : { key = k, value = v, propagate_at_launch = true }]
}
