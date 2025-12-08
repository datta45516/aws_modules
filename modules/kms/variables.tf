variable "region" { default = "us-east-1" }
variable "description" { type = string default = "Managed by Terraform" }
variable "tags" { type = map(string) default = {} }
