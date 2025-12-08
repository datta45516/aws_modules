
variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "tags" { type = map(string) default = {} }
