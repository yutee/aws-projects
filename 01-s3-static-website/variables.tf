
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-1"
  
}

variable "profile" {
  description = "The AWS profile to use for Terraform operations"
  type        = string
  default     = "adminuser"
}