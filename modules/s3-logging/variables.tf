variable "region" { default = "us-east-1" }
variable "target_bucket" { type = string }
variable "log_bucket" { type = string }
variable "log_prefix" { type = string default = "logs/" }
