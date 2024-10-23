
variable "name" {
    description = "The name of the EC2 instance"
}

variable "ami" {
    description = "The AMI to use for the EC2 instance"
}

variable "instance_type" {
    description = "The instance type to use for the EC2 instance"
}

variable "subnet_id" {
    description = "The subnet ID to use for the EC2 instance"
}

variable "security_group_id" {
    description = "The security group ID to use for the EC2 instance"
}