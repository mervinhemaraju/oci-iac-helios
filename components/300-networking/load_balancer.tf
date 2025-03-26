
# Load balancer definition
resource "oci_load_balancer_load_balancer" "test_load_balancer" {
  compartment_id = local.values.compartments.production
  display_name   = "web"
  shape          = "flexible"
  subnet_ids     = [oci_core_subnet.public_web.id]

  ip_mode = "IPV4"
  # is_delete_protection_enabled = "false"
  is_private = false
  # is_request_id_enabled = false
  # network_security_group_ids = var.load_balancer_network_security_group_ids
  # request_id_header = var.load_balancer_request_id_header
  reserved_ips {
    id = oci_core_public_ip.web.id
  }

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  freeform_tags = local.tags.defaults
}
