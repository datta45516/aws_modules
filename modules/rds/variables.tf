variable "name" { type = string }
variable "username" { type = string }
variable "password" { type = string sensitive = true }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "multi_az" {
  type    = bool
  default = false
}
