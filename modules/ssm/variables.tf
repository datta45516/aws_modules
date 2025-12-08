variable "region" { default = "us-east-1" }
variable "parameter_name" { type = string }
variable "parameter_value" { type = string sensitive = true }
variable "tags" { type = map(string) default = {} }
