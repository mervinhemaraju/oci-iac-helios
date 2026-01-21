# Create a reserved public IP for the load balance web computes
resource "oci_core_public_ip" "web" {
  compartment_id = local.values.compartments.production
  display_name   = "web-load-balancer"
  lifetime       = "RESERVED"
  lifecycle {
    ignore_changes = [private_ip_id]
  }

  freeform_tags = local.tags.defaults
}
