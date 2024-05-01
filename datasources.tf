# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Get the main admin user
data "oci_identity_users" "main_admin" {
  compartment_id = local.values.compartments.production
  name           = "Mervin Hemaraju"
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

# Gets the fault domains from this AZ
data "oci_identity_fault_domains" "this" {
  compartment_id      = local.values.compartments.production
  availability_domain = data.oci_identity_availability_domain.this.name
}

# # Get ths private ips for mongo compute
# data "oci_core_private_ips" "mongo" {
#   ip_address = local.networking.ip_address.mongo
#   subnet_id  = oci_core_subnet.public_database.id

#   depends_on = [
#     oci_core_instance.mongo,
#     oci_core_subnet.public_database
#   ]
# }
