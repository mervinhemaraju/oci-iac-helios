resource "oci_core_security_list" "private_database" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.database.id

  display_name = "private-database-sl"

  egress_security_rules {

    destination      = local.networking.cidr.vcn.database
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all traffic for the vcn's cidr block."

  }

  ingress_security_rules {

    source      = local.networking.cidr.vcn.database
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the vcn's cidr block."
  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "public_database" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.database.id

  display_name = "public-database-sl"

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Outbound internet traffic"

  }

  ingress_security_rules {

    source      = local.networking.cidr.vcn.database
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the vcn's cidr block."
  }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 80
      max = 80
    }

    description = "Allow HTTP traffic"
  }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 443
      max = 443
    }

    description = "Allow HTTPS traffic"
  }

  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 27017
      max = 27017
    }

    description = "Allow MongoDB traffic"
  }

  freeform_tags = local.tags.defaults
}
