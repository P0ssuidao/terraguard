variable "region" {
  default = "us-ashburn-1"
}

variable "availability_domain" {
  default = 1
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

variable "compartment_name" {
  type    = string
  default = "wireguard"
}

variable "shape" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "shape_config_ocpus" {
  type    = number
  default = 1
}

variable "shape_config_memory_in_gbs" {
  type    = number
  default = 1
}

variable "image_tag" {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaatepknur5eq4oo2gyfi37dcohen6cxwtanuuhiqplakmco2bl4jia"
}
