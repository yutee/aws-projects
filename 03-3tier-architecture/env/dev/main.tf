# ------------------------------
# networking module
module "networking" {
  source = "../../modules/network"

  vpc_name                               = var.vpc_name
  vpc_cidr_block                         = var.vpc_cidr_block
  vpc_availability_zones                 = var.vpc_availability_zones
  vpc_public_subnets                     = var.vpc_public_subnets
  vpc_private_subnets                    = var.vpc_private_subnets
  vpc_database_subnets                   = var.vpc_database_subnets
  vpc_create_database_subnet_group       = var.vpc_create_database_subnet_group
  vpc_create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  vpc_enable_nat_gateway                 = var.vpc_enable_nat_gateway
  vpc_single_nat_gateway                 = var.vpc_single_nat_gateway
}

# declare security groups here
# Security Group for AWS RDS DB
module "rdsdb_sg" {
  source     = "terraform-aws-modules/security-group/aws"
  version    = "4.0.0"
  depends_on = [module.networking]

  name        = "rdsdb-sg"
  description = "Access to MySQL DB for entire VPC CIDR Block (10.16.0.0/16)"
  vpc_id      = module.networking.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.networking.vpc_cidr_block
    },
  ]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]
}

module "ec2private_sg" {
  source     = "terraform-aws-modules/security-group/aws"
  version    = "4.0.0"
  depends_on = [module.networking]

  name        = "rdsdb-sg"
  description = "Access to Instances in Application Layer for entire VPC CIDR Block (10.16.0.0/16)"
  vpc_id      = module.networking.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow access within VPC"
      cidr_blocks = module.networking.vpc_cidr_block
    },
  ]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]
}

# ------------------------------
# rds database module
module "rds" {
  source     = "../../modules/rds"
  depends_on = [module.networking, module.rdsdb_sg]

  db_name                  = var.db_name
  db_instance_identifier   = var.db_instance_identifier
  db_username              = var.db_username
  db_password              = var.db_password
  vpc_database_subnets     = module.networking.vpc_database_subnets
  database_security_groups = [module.rdsdb_sg.security_group_id]
  subnet_group_name        = "tiri-vpc"
}

# ------------------------------
# auto-scaling group module
module "asg" {
  source = "../../modules/asg"

  #launch template
  name_prefix     = var.name_prefix
  image_id        = var.image_id
  instance_type   = var.instance_type
  security_groups = [module.ec2private_sg.security_group_id]

  #asg
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.vpc_private_subnets
}