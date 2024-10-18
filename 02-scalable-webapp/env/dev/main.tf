module "ec2" {
  source        = "../../modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.web_subnet_1.id
  user_data     = "${path.module}/scripts/user_data.sh"
}

module "elb" {
  source             = "../../modules/elb"
  subnet_ids         = [aws_subnet.web_subnet_1.id, aws_subnet.web_subnet_2.id]
  vpc_id             = aws_vpc.web_vpc.id
  elb_security_group = aws_security_group.elb_sg.id
}

module "asg" {
  source           = "../../modules/asg"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_id        = aws_subnet.web_subnet_1.id
  user_data        = "${path.module}/scripts/user_data.sh"
  desired_capacity = 2
  max_size         = 3
  min_size         = 1
  target_group_arn = module.elb.target_group_arn
}

# network configuration

resource "aws_vpc" "web_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "web_subnet_1" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "web_subnet_2" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "elb_sg" {
  vpc_id = aws_vpc.web_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web-igw"
  }
}

# Create a Route Table for Public Subnets
resource "aws_route_table" "web_public_rt" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_igw.id
  }

  tags = {
    Name = "web-public-rt"
  }
}

# Associate the Public Route Table with Subnet 1
resource "aws_route_table_association" "web_public_rt_assoc_1" {
  subnet_id      = aws_subnet.web_subnet_1.id
  route_table_id = aws_route_table.web_public_rt.id
}

# Associate the Public Route Table with Subnet 2
resource "aws_route_table_association" "web_public_rt_assoc_2" {
  subnet_id      = aws_subnet.web_subnet_2.id
  route_table_id = aws_route_table.web_public_rt.id
}