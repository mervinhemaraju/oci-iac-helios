
# * Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.token_doppler_iac_cloud_main
}

# * OCI Provider for Oracle cloud connection
provider "oci" {
  tenancy_ocid = data.doppler_secrets.prod_main.map.OCI_HELIOS_TENANCY_OCID
  user_ocid    = data.doppler_secrets.prod_main.map.OCI_HELIOS_USER_OCID
  fingerprint  = data.doppler_secrets.prod_main.map.OCI_HELIOS_FINGERPRINT
  private_key  = data.doppler_secrets.prod_main.map.OCI_HELIOS_PRIVATE_KEY
  region       = var.region
}

# * The Terraform Module
terraform {

  # * Required providers
  required_providers {

    doppler = {
      source = "DopplerHQ/doppler"
    }
    oci = {
      source  = "oracle/oci"
      version = "5.34.0"
    }
  }
}
