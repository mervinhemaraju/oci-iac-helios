# Define our data source to fetch secrets
data "doppler_secrets" "oci_creds" {
  project = local.secrets.oci
}

# Gets the availability domain from OCI
data "oci_identity_availability_domain" "this" {
  compartment_id = local.values.compartments.production
  ad_number      = 1
}

# Get the available LB certificates
data "oci_load_balancer_certificates" "web_certificates" {
  load_balancer_id = oci_load_balancer_load_balancer.web.id
}
