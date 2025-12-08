variable "region" { default = "us-east-1" }
variable "name" { type = string }
variable "cluster_id" { type = string }
variable "execution_role_arn" { type = string }
variable "container_definitions" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
