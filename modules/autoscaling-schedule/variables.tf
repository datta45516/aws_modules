variable "region" { default = "us-east-1" }
variable "asg_name" { type = string }
variable "min_size" { type = number }
variable "max_size" { type = number }
variable "desired_capacity" { type = number }
