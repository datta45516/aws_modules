terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_autoscaling_schedule" "scale_up" {
  scheduled_action_name = "${var.asg_name}-scale-up"
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  recurrence            = "0 9 * * MON-FRI"
  autoscaling_group_name = var.asg_name
}
