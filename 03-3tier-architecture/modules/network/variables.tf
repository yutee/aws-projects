# VPC Input Variables

# vpc name
variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "custom_vpc"
}

# vpc cidr block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.16.0.0/16"
}

# vpc availability zones
variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# vpc public subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.16.101.0/24", "10.16.102.0/24"]
}

# vpc private subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.16.1.0/24", "10.16.2.0/24"]
}

# vpc database subnets
variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type        = list(string)
  default     = ["10.16.151.0/24", "10.16.152.0/24"]
}

# vpc create database subnet group (true / false)
variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type        = bool
  default     = true
}

# vpc create database subnet route table (true or false)
variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type        = bool
  default     = true
}

# vpc enable nat gateway (true or false) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type        = bool
  default     = true
}

# vpc single nat gateway (true or talse)
variable "vpc_single_nat_gateway" {
  description = "Single NAT Gateway in one Availability Zone"
  type        = bool
  default     = true
}