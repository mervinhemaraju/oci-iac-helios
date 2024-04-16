
locals {

  tags = {
    defaults = {
      "Creator"     = "mervin.hemaraju",
      "Owner"       = "mervin.hemaraju",
      "Terraform"   = "Yes",
      "Project"     = "https://github.com/mervinhemaraju/oci-iac-helios",
      "Environment" = "Production"
    }
  }

  networking = {

    cidr = {
      vcn = {
        database = "10.16.0.0/16"
      }

      subnets = {
        public_database  = "10.16.100.0/24"
        private_database = "10.16.1.0/24"
      }
    }
    ip_address = {
      mongo = "10.16.100.10"
    }
  }

  values = {
    compute = {

      shape = "VM.Standard.A1.Flex"
      image = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa7xvogbygpoelc6373sg547342qojimntnk4dvemmekilet66nppq"

      mongo = {
        name = "mongo"
      }

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
