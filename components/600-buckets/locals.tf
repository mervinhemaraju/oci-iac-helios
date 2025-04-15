
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-helios",
      "environment" = "Production"
      "Component"   = "600-buckets"
    }
  }

  values = {
    compartments = {
      production = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_ROOT_ID
    }
  }
}
