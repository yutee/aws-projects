
## networking module variables
variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
}

variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type        = list(string)
}

variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type        = bool
}

variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type        = bool
}

variable "vpc_enable_nat_gateway" {
  description = "VPC Enable NAT Gateway"
  type        = bool
}

variable "vpc_single_nat_gateway" {
  description = "VPC Single NAT Gateway"
  type        = bool
}

## ---------------------------------------------------------------
## rds module variables
variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_instance_identifier" {
  description = "Database Instance Identifier"
  type        = string
}

variable "db_username" {
  description = "Database Username"
  type        = string
}

variable "db_password" {
  description = "Database Password"
  type        = string
}


## ---------------------------------------------------------------
## asg module variables

variable "name_prefix" {
  description = "Name Prefix"
  type        = string
}

variable "image_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "desired_capacity" {
  description = "Desired Capacity"
  type        = number
}

variable "max_size" {
  description = "Max Size"
  type        = number
}

variable "min_size" {
  description = "Min Size"
  type        = number
}

