variable "compartment_id" {}

variable "image_tag" {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaatepknur5eq4oo2gyfi37dcohen6cxwtanuuhiqplakmco2bl4jia"
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

variable "vcn_subnet_id" {}

variable "public_key" {}

variable "private_key" {}