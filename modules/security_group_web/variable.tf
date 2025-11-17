variable "vpc_id" {
  type = string
}

variable "allowed_http_cidrs" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
