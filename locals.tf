
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
    # ip_address = {
    #   web_01 = "10.15.100.10"
    #   web_02 = "10.15.100.20"
    # }
  }

  values = {
    compute = {

      shape = "VM.Standard.A1.Flex"

      # web_01 = {
      #   name = "web-01"
      # }

      # web_02 = {
      #   name = "web-02"
      # }

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
