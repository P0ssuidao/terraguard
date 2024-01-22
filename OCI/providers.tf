provider "oci" {
  region = var.region
}

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "5.23.0"
    }
  }
}
