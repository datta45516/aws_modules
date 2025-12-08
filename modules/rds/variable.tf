
variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "engine_version" { default = "16.0" }
variable "instance_class" { default = "db.t3.micro" }
variable "allocated_storage" { default = 20 }
variable "username" { type = string }
variable "password" { type = string sensitive = true }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "multi_az" { type = bool default = false }
variable "tags" { type = map(string) default = {} }

