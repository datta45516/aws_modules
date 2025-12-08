
variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "db_name" { type = string }
variable "username" { type = string }
variable "password" { type = string sensitive = true }
variable "subnet_ids" { type = list(string) }
