variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "service_role_arn" { type = string }
variable "tags" { type = map(string) default = {} }
