
variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { default = "t3.micro" }
variable "subnet_id" { type = string }
variable "security_group_ids" { type = list(string) }
variable "key_name" { type = string default = "" }
variable "user_data" { type = string default = "" }
variable "tags" { type = map(string) default = {} }
