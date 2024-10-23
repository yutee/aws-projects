output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
}

output "rdsdb_sg_id" {
  description = "The ID of the RDS security group"
  value       = module.rdsdb_sg.security_group_id
}

output "rdsdb_vpc_id" {
  description = "The ID of the VPC"
  value       = module.rdsdb_sg.security_group_vpc_id
}