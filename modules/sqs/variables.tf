
variable "region" { default = "us-east-1" }
variable "queue_name" { type = string }
variable "tags" { type = map(string) default = {} }
