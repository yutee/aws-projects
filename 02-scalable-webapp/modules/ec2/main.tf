resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  user_data     = base64encode(file(var.user_data))

  tags = {
    Name = "web-server-instance"
  }
}