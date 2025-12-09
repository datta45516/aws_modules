variable "bucket" {
  description = "Name of the S3 bucket. Must be unique."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
