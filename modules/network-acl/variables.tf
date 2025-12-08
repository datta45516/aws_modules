
variable "region" { default = "us-east-1" }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "tags" { type = map(string) default = {} }
