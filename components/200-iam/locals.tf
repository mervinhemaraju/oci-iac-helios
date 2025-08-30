
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-helios",
      "environment" = "Production"
      "Component"   = "200-iam"
    }
  }

  secrets = {
    oci = "cloud-oci-creds"
  }

  values = {
    compartments = {
      production = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.oci_creds.map.OCI_HELIOS_COMPARTMENT_ROOT_ID

      root_gaia = data.doppler_secrets.oci_creds.map.OCI_GAIA_COMPARTMENT_ROOT_ID
    }

    groups = {
      vcn_admins     = "vcn-admins"
      administrators = "Administrators"
      gaia_groups = {
        drg_admins = {
          name = "drg-admins"
          id   = jsondecode(data.doppler_secrets.oci_creds.map.OCI_GAIA_GROUPS)["drg-admins"]
        }
      }
    }
  }
}
