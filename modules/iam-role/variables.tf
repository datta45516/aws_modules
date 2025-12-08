
variable "region" { type = string default = "us-east-1" }
variable "role_name" { type = string }
variable "assume_role_policy" { type = string }
variable "policy_json" { type = string default = "" }
variable "tags" { type = map(string) default = {} }
