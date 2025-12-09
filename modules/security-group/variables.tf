variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name" { type = string }
variable "vpc_id" { type = string }
variable "ingress_rules" {
  type    = list(any)
  default = []
}
