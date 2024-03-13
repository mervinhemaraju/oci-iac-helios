locals {

  constants = {
    # compartment_id_production = data.doppler_secrets.prod_main.map.OCI_HELIOS_COMPARTMENT_PRODUCTION_ID


    compute = {

      image = {
        ubuntu_oci        = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa7njfmfxcybo66dwsn4u6asz5ecsszyto56ufbltkp7kugixnctxa"
        centos_stream_oci = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaaqtgzhnzsg3pu6zl57crqijf3tidkp7j35szwl573thxcfrl53jva"
      }

      ip_address = {

        web_01 = {
          private = "10.16.1.223"
        }
      }
    }
  }
}
