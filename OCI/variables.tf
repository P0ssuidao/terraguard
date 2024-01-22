variable "region" {
  type    = string
  default = "us-ashburn-1"
}

variable "key_name" {
  type    = string
  default = "wirevpn"
}

variable "mobile" {
  type    = bool
  default = false
}

variable "vcn_name" {
  type    = string
  default = "wire-vcn"
}

variable "vcn_dns_label" {
  type    = string
  default = "dnswirevcn"
}