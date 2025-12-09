variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name" { type = string }
variable "vpc_id" { type = string }

variable "description" {
  type    = string
  default = "Managed by Terraform"
}

variable "ingress_rules" {
  type    = list(any)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
