variable "IAM-ro-users" {
  type    = list(string)
  default = ["emadu@gmail.com", "dibangox@gmail.com"]
}

variable "module_version" {
  type    = string
  default = "1.0.0"
}
