
# Create a network security group for mongo compute
resource "oci_core_network_security_group" "mongo" {

  compartment_id = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  vcn_id         = oci_core_vcn.database.id
  display_name   = "nsg-database"
  freeform_tags  = local.tags.defaults
}

# Enable HTTP traffic
resource "oci_core_network_security_group_security_rule" "http" {

  network_security_group_id = oci_core_network_security_group.mongo.id
  direction                 = "INGRESS"
  protocol                  = 6 # TCP

  description = "Allow MongoDB traffic from Helios Web servers."
  source      = "10.15.0.0/0"
  source_type = "CIDR_BLOCK"
  stateless   = false

  tcp_options {
    source_port_range {
      max = 27017
      min = 27017
    }
  }
}
