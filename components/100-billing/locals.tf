
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-helios",
      "Environment" = "Production"
      "Component"   = "100-billing"
    }
  }

  values = {
    # tenancy = data.doppler_secrets.oci_creds.map.OCI_HELIOS_TENANCY_OCID
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_ROOT_ID
    }
  }
}
