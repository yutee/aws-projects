
variable "email_addresses" {
    description = "List of email addresses to notify when the budget is exceeded"
    type        = list(string)
}

variable "amount" {
    description = "Amount in USD to set as the budget limit"
    type        = list(string)
}

variable "notification_threshold" {
    description = "Threshold in USD to set for the budget notification"
    type        = list(number)
}

variable "region" {
  description = "region for provider config"
  default     = "us-east-1"
}