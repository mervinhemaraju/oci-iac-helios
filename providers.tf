
# * Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.doppler_token
}

# * OCI Provider for Oracle cloud connection
provider "oci" {
  tenancy_ocid = data.doppler_secrets.this.map.OCI_HELIOS_TENANCY_OCID
  user_ocid    = data.doppler_secrets.this.map.OCI_HELIOS_USER_OCID
  fingerprint  = data.doppler_secrets.this.map.OCI_HELIOS_FINGERPRINT
  private_key  = data.doppler_secrets.this.map.OCI_HELIOS_PRIVATE_KEY
  region       = "af-johannesburg-1"

  ignore_defined_tags = [
    "Oracle-Tags.CreatedBy",
    "Oracle-Tags.CreatedOn",
    "My-Tags.AwesomeTag"
  ]
}

# * The Terraform Module
terraform {

  # * Required providers
  required_providers {

    doppler = {
      source = "DopplerHQ/doppler"
    }
    oci = {
      source = "oracle/oci"
    }
  }
}
