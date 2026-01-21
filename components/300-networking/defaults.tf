# The default resources that comes with a VCN
resource "oci_core_default_security_list" "dev" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.dev.default_security_list_id
}

resource "oci_core_default_route_table" "dev" {
  compartment_id             = local.values.compartments.production
  manage_default_resource_id = oci_core_vcn.dev.default_route_table_id
}
