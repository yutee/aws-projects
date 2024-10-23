# Terraform AWS RDS Database Variables

# DB Name
variable "db_name" {
  description = "RDS Database Name"
  type        = string
}

# DB Instance Identifier
variable "db_instance_identifier" {
  description = "RDS Database Instance Identifier"
  type        = string
}

# DB Username - Enable Sensitive flag
variable "db_username" {
  description = "RDS Database Administrator Username"
  type        = string
}

# DB Password - Enable Sensitive flag
variable "db_password" {
  description = "AWS RDS Database Administrator Password"
  type        = string
  sensitive   = true
}

variable "vpc_database_subnets" {
    description = "Database Subnets"
    type        = list(string)
}

variable "database_security_groups" {
    description = "Database Security Groups"
    type        = list(string)
}

variable "subnet_group_name" {
    description = "Database Subnet Group Name"
    type        = string
}