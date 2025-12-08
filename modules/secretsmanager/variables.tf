
variable "region" { default = "us-east-1" }
variable "secret_name" { type = string }
variable "secret_string" { type = string sensitive = true }
variable "tags" { type = map(string) default = {} }
