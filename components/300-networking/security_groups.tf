resource "oci_core_security_list" "private_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "private-mgmt-sl"

  # Allows SSH traffic from the internet
  ingress_security_rules {
    source      = local.networking.cidr.vcn.web
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allow SSH traffic from the internet to the web VCN CIDR."
  }

  # Allows all traffic to the private-web vcn
  egress_security_rules {
    destination      = local.networking.cidr.subnets.private_web
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allows all outbound traffic to the private-web subnet."

  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "private_web" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "private-web-sl"

  # Allows all ingress traffic from the private db subnet in GAIA account
  ingress_security_rules {
    source      = local.networking.cidr.subnets.private_database_gaia
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the private-db subnet in the GAIA account (Cross connection)."
  }

  # Allows all ingress traffic from the private mgmt subnet
  ingress_security_rules {
    source      = local.networking.cidr.subnets.private_mgmt
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the private-mgmt subnet."
  }

  # Allows all ingress traffic from the public web subnet
  ingress_security_rules {

    source      = local.networking.cidr.subnets.public_web
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the public-web subnet."
  }

  # Allows all egress traffic to the internet
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  freeform_tags = local.tags.defaults
}

resource "oci_core_security_list" "public_web" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "public-web-sl"

  # Allows all egress traffic to the internet
  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  # Allows all ingress traffic from the web subnet
  ingress_security_rules {

    source      = local.networking.cidr.vcn.web
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the web vcn's cidr block."
  }

  # Allows all ingress HTTP traffic from the internet
  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 #* TCP protocol code

    description = "Allow Inbound HTTP Traffic from the Internet"

    tcp_options {
      max = 80
      min = 80
    }
  }

  # Allows all ingress HTTPS traffic from the internet
  ingress_security_rules {

    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = 6 #* TCP protocol code

    description = "Allow Inbound HTTPS Traffic from the Internet"

    tcp_options {
      max = 443
      min = 443
    }
  }

  freeform_tags = local.tags.defaults
}
