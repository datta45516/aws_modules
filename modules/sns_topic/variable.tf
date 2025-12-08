
variable "region" { default = "us-east-1" }
variable "topic_name" { type = string }
variable "subscribers" { type = list(object({ protocol = string, endpoint = string })) default = [] }
variable "tags" { type = map(string) default = {} }
