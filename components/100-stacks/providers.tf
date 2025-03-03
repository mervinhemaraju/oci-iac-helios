# Providers
terraform {

  # Terraform version
  required_version = ">= 1.7.0"

  # Backend configuration
  backend "s3" {
    region = var.region
    key    = "${var.bucket_key_prefix}/oci-cloud-helios/state.tf"
    bucket = var.bucket_name
  }

  # Required Providers
  required_providers {
    # Spacelift provider
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.8.0"
    }
  }
}

# Spacelift provider configuration
provider "spacelift" {}
