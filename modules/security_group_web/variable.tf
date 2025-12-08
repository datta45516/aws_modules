
variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "description" { type = string default = "Managed by Terraform" }
variable "vpc_id" { type = string }
variable "ingress_rules" { type = list(object({ cidr = string, from_port = number, to_port = number, protocol = string, description = string })) }
variable "tags" { type = map(string) default = {} }
