
variable "region" { default = "us-east-1" }
variable "cluster_name" { type = string }
variable "tags" { type = map(string) default = {} }
