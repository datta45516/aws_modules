variable "region" { default = "us-east-1" }
variable "az" { type = string }
variable "size_gb" { type = number }
variable "tags" { type = map(string) default = {} }
