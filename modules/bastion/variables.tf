
variable "region" { default = "us-east-1" }
variable "ami_id" { type = string }
variable "public_subnet_id" { type = string }
variable "vpc_id" { type = string }
variable "key_name" { type = string }
variable "ssh_allowed_cidr" { type = string default = "0.0.0.0/0" }
variable "tags" { type = map(string) default = {} }
