
# * Infisical Provider for Infisical Secrets Manager
provider "infisical" {
  service_token = var.token_infisical_iac_cloud_main
}

# * OCI Provider for Oracle cloud connection
provider "oci" {
  tenancy_ocid = data.infisical_secrets.cloud_iac_main.secrets["OCI_HELIOS_TENANCY_OCID"].value
  user_ocid    = data.infisical_secrets.cloud_iac_main.secrets["OCI_HELIOS_USER_OCID"].value
  fingerprint  = data.infisical_secrets.cloud_iac_main.secrets["OCI_HELIOS_FINGERPRINT"].value
  private_key  = data.infisical_secrets.cloud_iac_main.secrets["OCI_HELIOS_PRIVATE_KEY"].value
  region       = "af-johannesburg-1"
}

# * The Terraform Module
terraform {

  # * Required providers
  required_providers {

    infisical = {
      source = "infisical/infisical"
    }

    oci = {
      source = "oracle/oci"
    }
  }
}
