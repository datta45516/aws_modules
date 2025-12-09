variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
