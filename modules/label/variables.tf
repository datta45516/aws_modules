variable "name" { type = string }
variable "environment" { type = string }
variable "additional_tags" { type = map(string) default = {} }
