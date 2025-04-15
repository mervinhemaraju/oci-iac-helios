# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

data "oci_core_vcns" "web" {
  compartment_id = local.values.compartments.production

  display_name = "web"
}

data "oci_core_subnets" "private_web" {
  compartment_id = local.values.compartments.production
  display_name   = "private-web"
  vcn_id         = data.oci_core_vcns.web.virtual_networks[0].id
}

data "oci_core_subnets" "private_mgmt" {
  compartment_id = local.values.compartments.production
  display_name   = "private-mgmt"
  vcn_id         = data.oci_core_vcns.web.virtual_networks[0].id
}
