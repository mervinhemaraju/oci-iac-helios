# # Service stack for OCI Helios
# module "service_cloud_oci_helios" {
#   source           = "spacelift.io/mervinhemaraju/module-terraform-spacelift-stack/spacelift"
#   version          = "1.4.2"
#   description      = "This is the service IaC stack for the OCI infrastructure codenamed Helios"
#   stack_name       = "service/cloud/oci/helios/administrative"
#   stack_repository = "oci-iac-helios"

#   administrative     = true
#   before_init        = local.constants.before_init_tofu
#   aws_integration_id = spacelift_aws_integration.ares.id

#   project_root = "components/100-stacks"

#   labels = [
#     "cloud",
#     "oci",
#     "oci-helios",
#     "terraform",
#     "doppler",
#     "helios",
#   ]
# }
