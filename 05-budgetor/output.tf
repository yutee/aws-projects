
output "budgets_created" {
  description = "Number of budgets created"
  value       = format("%d Budgets created", length(aws_budgets_budget.usage_budget) + 1)
}