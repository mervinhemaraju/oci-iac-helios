
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
    ip_address = {
      web_01 = "10.16.20.10"
      web_02 = "10.16.20.20"
    }

    cidr = {
      vcn = {
        web = "10.16.0.0/16"
      }
      subnets = {
        private_mgmt          = "10.16.10.0/24"
        private_web           = "10.16.20.0/24"
        public_web            = "10.16.100.0/24"
        private_database_gaia = "10.18.20.0/24" # (This is found in the GAIA account)
      }
    }
  }

  gaia_account = {
    database_drg = jsondecode(data.doppler_secrets.oci_creds.map.OCI_GAIA_DRG_DATABASE)
  }

  values = {

    tenancy = data.doppler_secrets.oci_creds.map.OCI_HELIOS_TENANCY_OCID

    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_ROOT_ID
    }
  }
}
