
variable "region" { default = "us-east-1" }
variable "function_name" { type = string }
variable "runtime" { default = "nodejs20.x" }
variable "source_code" { type = string }
variable "environment_variables" { type = map(string) default = {} }
variable "tags" { type = map(string) default = {} }
