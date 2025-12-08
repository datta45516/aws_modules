variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "vpc_id" { type = string }
variable "listener_arn" { type = string }
variable "priority" { type = number }
variable "path_pattern" { type = string }
