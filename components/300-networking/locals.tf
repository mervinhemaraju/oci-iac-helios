
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-helios",
      "environment" = "Production"
    }
  }

  networking = {

    cidr = {
      vcn = {
        web = "10.16.0.0/16"
      }
      subnets = {
        private_mgmt = "10.16.10.0/24"
        public_web   = "10.16.100.0/24"
      }
    }
    ip_address = {
      web_01 = "10.16.100.10"
      web_02 = "10.16.100.20"
    }
  }

  values = {

    tenancy = data.doppler_secrets.prod_main.map.OCI_HELIOS_TENANCY_OCID

    compartments = {
      production = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
      root       = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_ROOT_ID
    }

    compute = {

      shape = "VM.Standard.A1.Flex"
      image = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa7xvogbygpoelc6373sg547342qojimntnk4dvemmekilet66nppq"

      plugins_config = [
        {
          name          = "Bastion"
          desired_state = "ENABLED"
        },
        {
          name          = "OS Management Service Agent"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Run Command"
          desired_state = "ENABLED"
        },
        {
          name          = "Compute Instance Monitoring"
          desired_state = "ENABLED"
        }
      ]
    }
  }
}
