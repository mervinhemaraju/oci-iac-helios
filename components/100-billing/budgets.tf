# Creates a zero spend budget
resource "oci_budget_budget" "zero_spend" {
  compartment_id = local.values.compartments.root
  amount         = 1
  reset_period   = "MONTHLY"

  description  = "A zero spend budget for OCI Helios"
  display_name = "budget-zero-spend"
  target_type  = "COMPARTMENT"
  targets = [
    local.values.compartments.production
  ]
}

resource "oci_budget_alert_rule" "zero_spend" {
  budget_id      = oci_budget_budget.zero_spend.id
  threshold      = 0.1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "zero-strict-threshold"
  message      = "The zero spend budget has been breached on OCI."
  recipients   = "mervinhemaraju16@gmail.com"

  depends_on = [
    oci_budget_budget.zero_spend
  ]
}

# Creates a limit budget
resource "oci_budget_budget" "limit" {
  compartment_id = local.values.compartments.root
  amount         = 8
  reset_period   = "MONTHLY"

  description  = "A limit budget for OCI Helios"
  display_name = "budget-limit"
  target_type  = "COMPARTMENT"
  targets = [
    local.values.compartments.production
  ]
}

resource "oci_budget_alert_rule" "limit" {
  budget_id      = oci_budget_budget.limit.id
  threshold      = 0.1
  threshold_type = "ABSOLUTE"
  type           = "ACTUAL"

  display_name = "limit-strict-threshold"
  message      = "The limit budget has been breached on OCI."
  recipients   = "mervinhemaraju16@gmail.com"

  depends_on = [
    oci_budget_budget.limit
  ]
}
