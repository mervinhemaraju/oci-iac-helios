# Creates a zero spend budget
resource "oci_budget_budget" "oci_zero_spend_budget" {
  compartment_id = local.values.compartments.root
  amount         = 1
  reset_period   = "MONTHLY"

  description  = "A zero spend budget for OCI"
  display_name = "budget-zero-spend"
  target_type  = "COMPARTMENT"
  targets = [
    local.values.compartments.production
  ]
}

resource "oci_budget_alert_rule" "oci_zsb_rule" {
  budget_id      = oci_budget_budget.oci_zero_spend_budget.id
  threshold      = 0.1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "zero-strict-threshold"
  message      = "The zero spend budget has been breached on OCI."
  recipients   = "mervinhemaraju16@gmail.com"

  depends_on = [
    oci_budget_budget.oci_zero_spend_budget
  ]
}
