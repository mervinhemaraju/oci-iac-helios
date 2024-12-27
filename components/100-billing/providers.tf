
# Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.token_doppler_iac_cloud_main
}

# OCI Provider for Oracle cloud connection
provider "oci" {
  tenancy_ocid = data.doppler_secrets.prod_main.map.OCI_HELIOS_TENANCY_OCID
  user_ocid    = data.doppler_secrets.prod_main.map.OCI_HELIOS_USER_OCID
  fingerprint  = data.doppler_secrets.prod_main.map.OCI_HELIOS_FINGERPRINT
  private_key  = data.doppler_secrets.prod_main.map.OCI_HELIOS_PRIVATE_KEY
  region       = var.region
}

# The Terraform Module
terraform {

  # The required tf version
  required_version = "1.4.0"

  # Backend configuration
  backend "s3" {
    region = "eu-west-1"
    key    = "projects/oci-iac-helios/billing/state.tf"
    bucket = "mervin-iac-state-files"
  }

  # Required providers
  required_providers {

    # Doppler provider
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.7.0"
    }

    # OCI provider
    oci = {
      source  = "oracle/oci"
      version = "5.34.0"
    }

    # AWS provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}
