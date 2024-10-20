
resource "aws_budgets_budget" "zero_cost_budget" {
  name              = "Zero-Spend-Budget"
  budget_type       = "COST"
  limit_amount      = "0.01"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  # Notifications for actual or forecasted spend exceeding zero
  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = var.email_addresses
  }
}

resource "aws_budgets_budget" "usage_budget" {
  count             = length(var.amount)  
  name              = "Student-Spend-Budget-${count.index + 1}"
  budget_type       = "COST"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  limit_amount      = var.amount[count.index]

  # Notifications for when usage exceeds a particular amount in $
  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = var.notification_threshold[count.index]
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = var.email_addresses
  }
}
