resource "oci_core_security_list" "private_mgmt" {

  compartment_id = local.values.compartments.production
  vcn_id         = oci_core_vcn.web.id

  display_name = "private-mgmt-sl"

  ingress_security_rules {
    # Allows SSH traffic from the internet

    source      = local.networking.cidr.vcn.web
    source_type = "CIDR_BLOCK"
    protocol    = 6 # TCP

    tcp_options {
      min = 22
      max = 22
    }

    description = "Allow SSH traffic from the internet to the web VCN CIDR."
  }

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


  ingress_security_rules {

    # Allows all traffic from the private mgmt subnet

    source      = local.networking.cidr.subnets.private_mgmt
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic from the private-mgmt subnet."
  }

  egress_security_rules {

    # Allows all traffic on egress
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

  egress_security_rules {

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"

    description = "Allow all outbound traffic to the internet."

  }

  ingress_security_rules {

    source      = local.networking.cidr.vcn.web
    source_type = "CIDR_BLOCK"
    protocol    = "all"

    description = "Allow all traffic for the web vcn's cidr block."
  }

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
