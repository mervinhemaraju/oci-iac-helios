# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Get the main admin user
data "oci_identity_users" "main_admin" {
  compartment_id = local.values.compartments.root
  name           = "Mervin Hemaraju"
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

data "oci_core_vcns" "web" {
  #Required
  compartment_id = local.values.compartments.production

  #Optional
  display_name = "web"
}

data "oci_core_subnets" "public_web" {
  compartment_id = local.values.compartments.production
  display_name   = "public-web"
  vcn_id         = data.oci_core_vcns.web.virtual_networks[0].id
}

data "oci_core_private_ips" "web_01" {
  ip_address = local.networking.ip_address.web_01
  subnet_id  = data.oci_core_subnets.public_web.subnets[0].id
}

data "oci_core_private_ips" "web_02" {
  ip_address = local.networking.ip_address.web_02
  subnet_id  = data.oci_core_subnets.public_web.subnets[0].id
}

