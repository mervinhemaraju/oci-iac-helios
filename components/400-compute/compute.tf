

# Create a compute instance for web_01
resource "oci_core_instance" "web_01" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = local.values.compute.name.web_01

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 12
    ocpus         = 2
    vcpus         = 2
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.private_web.subnets[0].id
    assign_public_ip       = false
    private_ip             = local.networking.ip_address.web_01
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "100"
    boot_volume_vpus_per_gb = 120
  }

  agent_config {
    dynamic "plugins_config" {
      for_each = local.values.compute.plugins_config
      content {
        desired_state = plugins_config.value.desired_state
        name          = plugins_config.value.name
      }
    }
  }

  freeform_tags = local.tags.defaults

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC

    # User data from YAML template file
    user_data = base64encode(templatefile("${path.module}/templates/cloud_init.yml", {
      hostname             = local.values.compute.name.web_01
      authorized_ssh_key   = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC
      cloudflare_api_token = data.doppler_secrets.apps_creds.map.CLOUDFLARE_TERRAFORM_TOKEN
    }))
  }
}

# Create a compute instance for web_02
resource "oci_core_instance" "web_02" {

  compartment_id = local.values.compartments.production

  availability_domain = data.oci_identity_availability_domain.this.name

  display_name = local.values.compute.name.web_02

  shape = local.values.compute.shape

  shape_config {
    memory_in_gbs = 12
    ocpus         = 2
    vcpus         = 2
  }

  create_vnic_details {
    subnet_id              = data.oci_core_subnets.private_web.subnets[0].id
    assign_public_ip       = false
    private_ip             = local.networking.ip_address.web_02
    skip_source_dest_check = true
  }

  source_details {
    source_type             = "image"
    source_id               = local.values.compute.image
    boot_volume_size_in_gbs = "100"
    boot_volume_vpus_per_gb = 120
  }

  agent_config {
    dynamic "plugins_config" {
      for_each = local.values.compute.plugins_config
      content {
        desired_state = plugins_config.value.desired_state
        name          = plugins_config.value.name
      }
    }
  }

  freeform_tags = local.tags.defaults

  metadata = {
    ssh_authorized_keys = data.doppler_secrets.oci_creds.map.OCI_COMPUTE_KEY_PUBLIC
  }
}
