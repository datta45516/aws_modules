
variable "region" { default = "us-east-1" }
variable "create_zone" { type = bool default = false }
variable "zone_name" { type = string default = "" }
variable "zone_id" { type = string default = "" }
variable "record_name" { type = string }
variable "record_type" { type = string }
variable "records" { type = list(string) }
variable "tags" { type = map(string) default = {} }
