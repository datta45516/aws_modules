variable "region" { default = "us-east-1" }
variable "username" { type = string }
variable "tags" { type = map(string) default = {} }
