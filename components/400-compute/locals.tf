
locals {

  tags = {
    defaults = {
      "creator"     = "mervin.hemaraju",
      "owner"       = "mervin.hemaraju",
      "terraform"   = "Yes",
      "project"     = "https://github.com/mervinhemaraju/oci-iac-helios",
      "environment" = "Production"
      "Component"   = "400-compute"
    }
  }

  networking = {
    ip_address = {
      web_01 = "10.16.20.10"
      web_02 = "10.16.20.20"
    }
  }

  values = {

    compartments = {
      production = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
    }


    bastions = {
      "private-jump-01" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
      "private-jump-02" = {
        max_session_ttl_in_seconds   = 10800
        client_cidr_block_allow_list = ["0.0.0.0/0"]
      }
    }

    compute = {

      name = {
        web_01 = "web-01"
        web_02 = "web-02"
      }

      shape = "VM.Standard.A1.Flex"
      # image = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa7xvogbygpoelc6373sg547342qojimntnk4dvemmekilet66nppq"
      image = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaadpxuxt4xtk4lagfqlaedax5g2wnqkgcf6xchgbnrikup54ijyrya"

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
