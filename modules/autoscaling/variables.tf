
variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { default = "t3.micro" }
variable "subnet_ids" { type = list(string) }
variable "min_size" { default = 1 }
variable "max_size" { default = 3 }
variable "desired_capacity" { default = 1 }
variable "user_data" { default = "" }
variable "target_group_arns" { type = list(string) default = [] }
variable "tags" { type = map(string) default = {} }
