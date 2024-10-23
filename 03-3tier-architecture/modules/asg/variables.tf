
variable "name_prefix" {
  description = "Name prefix for the Launch Template"
  type        = string
}

variable "image_id" {
  description = "AMI ID for the Launch Template"
  type        = string
}

variable "instance_type" {
  description = "Instance Type for the Launch Template"
  type        = string
}

variable "security_groups" {
  description = "Security Groups for the Launch Template"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired Capacity for the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Max Size for the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Min Size for the Auto Scaling Group"
  type        = number
}

variable "vpc_zone_identifier" {
  description = "VPC Zone Identifier for the Auto Scaling Group"
  type        = list(string)
}