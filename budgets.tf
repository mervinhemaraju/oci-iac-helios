# Creates a zero spend budget
resource "oci_budget_budget" "oci_zero_spend_budget" {
  compartment_id = data.infisical_secrets.cloud_iac_main.secrets["OCI_HELIOS_COMPARTMENT_ROOT_ID"].value
  amount         = 1
  reset_period   = "MONTHLY"

  description  = "A zero spend budget for OCI"
  display_name = "zero-spend-budget"
  target_type  = "COMPARTMENT"
  targets = [
    data.infisical_secrets.cloud_iac_main.secrets["OCI_HELIOS_COMPARTMENT_PRODUCTION_ID"].value
  ]
}

resource "oci_budget_alert_rule" "oci_zsb_rule" {
  budget_id      = oci_budget_budget.oci_zero_spend_budget.id
  threshold      = 0.1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "0-strict-threshold"
  message      = "The zero spend budget has been breached on OCI."
  recipients   = "mervinhemaraju16@gmail.com"

  depends_on = [
    oci_budget_budget.oci_zero_spend_budget
  ]
}