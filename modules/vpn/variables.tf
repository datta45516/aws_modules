
variable "region" { default = "us-east-1" }
variable "vpc_id" { type = string }
variable "customer_ip" { type = string }
variable "tags" { type = map(string) default = {} }
