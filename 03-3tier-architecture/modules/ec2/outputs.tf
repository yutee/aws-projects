output "ami" {
    description = "The AMI to use for the EC2 instance"
    value       = module.ec2.ami
}

output "public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = module.ec2.public_ip
}