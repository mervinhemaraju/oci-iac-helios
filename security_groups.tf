resource "oci_core_security_list" "private_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "private-mgmt-sl"

  egress_security_rules {

    destination      = local.networking.cidr.vcn.database
    destination_type = "CIDR_BLOCK"
    protocol         = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allow SSH traffic to the database vcn CIDR."

  }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allow SSH traffic from the Internet to the private mgmt subnet."
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "public_database" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.database.id

  display_name = "public-database-sl"

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  ingress_security_rules {

    source      = local.networking.cidr.vcn.database
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the database vcn's cidr block."
  }

  ingress_security_rules {

    source      = local.networking.cidr.vcn.web
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the web vcn's cidr block."
  }

  freeform_tags = local.tags.defaults
}
