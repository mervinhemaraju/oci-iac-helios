
# * Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.token_doppler_global
}

# * OCI Provider for Oracle cloud connection
provider "oci" {
  tenancy_ocid = data.doppler_secrets.oci_creds.map.OCI_HELIOS_TENANCY_OCID
  user_ocid    = data.doppler_secrets.oci_creds.map.OCI_HELIOS_USER_OCID
  fingerprint  = data.doppler_secrets.oci_creds.map.OCI_HELIOS_FINGERPRINT
  private_key  = data.doppler_secrets.oci_creds.map.OCI_HELIOS_PRIVATE_KEY
  region       = var.region
}

provider "oci" {
  alias        = "gaia"
  tenancy_ocid = data.doppler_secrets.oci_creds.map.OCI_GAIA_TENANCY_OCID
  user_ocid    = data.doppler_secrets.oci_creds.map.OCI_GAIA_USER_OCID
  fingerprint  = data.doppler_secrets.oci_creds.map.OCI_GAIA_FINGERPRINT
  private_key  = data.doppler_secrets.oci_creds.map.OCI_GAIA_PRIVATE_KEY
  region       = var.region
}

# * The Terraform Module
terraform {

  # * The required tf version
  required_version = "1.4.0"

  # * Required providers
  required_providers {

    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.7.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "5.34.0"
    }
  }
}
