variable "region" { default = "us-east-1" }
variable "cluster_id" { type = string }
variable "execution_role_arn" { type = string }
variable "gh_user" { type = string }
variable "gh_token" { type = string sensitive = true }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
