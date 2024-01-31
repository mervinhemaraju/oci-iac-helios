locals {

  constants = {
    compartment_id_production = data.doppler_secrets.this.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID
  }
}
