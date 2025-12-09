variable "region" { default = "us-east-1" }
variable "cluster_name" { type = string }
variable "kubernetes_version" { default = "1.30" }
variable "subnet_ids" { type = list(string) }
variable "tags" {
type = map(string)
default = {}
}
