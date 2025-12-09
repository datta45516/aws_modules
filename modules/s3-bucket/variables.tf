variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket" {
  type = string
}

variable "versioning_enabled" {
  type    = bool
  default = true
}

variable "enable_lifecycle" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
