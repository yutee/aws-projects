module "ec2" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "5.7.1"
    
    name          = var.name
    ami           = var.ami
    instance_type = var.instance_type
    subnet_id     = var.subnet_id

    vpc_security_group_ids = [var.security_group_id]
    associate_public_ip_address = true
}