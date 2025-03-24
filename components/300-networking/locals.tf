
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-helios",
      "environment" = "Production"
      "Component"   = "300-networking"
    }
  }

  networking = {

    cidr = {
      vcn = {
        web = "10.16.0.0/16"
      }
      subnets = {
        private_mgmt = "10.16.10.0/24"
        private_web  = "10.16.20.0/24"
        public_web   = "10.16.100.0/24"
      }
    }
  }

  values = {

    tenancy = data.doppler_secrets.prod_main.map.OCI_HELIOS_TENANCY_OCID

    compartments = {
      production = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_ROOT_ID
    }
  }
}
