variable "IAM-ro-users" {
  type    = list(string)
  
}

variable "module_version" {
  type    = string
  default = "1.0.0"
}

variable "iam_group_name" {
  type    = string
  
}

variable "tags" {
  type    = map(string)
}

variable "force_destroy" {
  type    = bool
}

variable "dynamic_policy" {
  type    = string
}

variable "region" {}


