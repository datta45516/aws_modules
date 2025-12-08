
variable "region" { default = "us-east-1" }
variable "log_group_name" { type = string }
variable "retention_days" { default = 30 }
variable "tags" { type = map(string) default = {} }
