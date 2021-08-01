variable "project_id" {
  type = string
}
variable "zone" {
  type = string
  default = "us-east1-b"
}

variable "region" {
  type = string
  default = "us-east1"
}

variable "key_name" {
  type = string
  default = "wirekey"
}

variable "vpc" {
  type = string
  default = "default"
}

variable "mobile" {
  type = bool
  default = false
}