# 1: Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = format("%s-%s-%s-myvpc", var.environment, var.clientName, var.product)
  }
}

# 2: Create a public subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = "ap-south-1a"
  cidr_block        = var.public_subnet_cidr
  tags = {
    "Name" = format("%s-%s-%s-public-db-subnet", var.environment, var.clientName, var.product)
  }
}

# 3: create IGW
resource "aws_internet_gateway" "myIgw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = format("%s-%s-%s-myIgw", var.environment, var.clientName, var.product)
  }
}

# 4: route Tables for public subnet
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIgw.id
  }
  tags = {
    "Name" = format("%s-%s-%s-PublicRT", var.environment, var.clientName, var.product)
  }
}

# 5: route table association public subnet 
resource "aws_route_table_association" "PublicRTAssociation" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRT.id
}


# 6: securitygroup using Terraform
resource "aws_security_group" "my_sg" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = format("%s-%s-%s-Terraform-SG", var.environment, var.clientName, var.product)
  }
}

# Create an EC2 instance and attach security group
resource "aws_instance" "my_instance" {
  ami                         = "ami-0f5ee92e2d63afc18"
  instance_type               = "t2.micro"
  key_name                    = "test"
  security_groups             = [aws_security_group.my_sg.id]
  subnet_id                   = aws_subnet.PublicSubnet.id
  associate_public_ip_address = true

  tags = {
    "Name" = format("%s-%s-%s", var.environment, var.clientName, var.product)
  }
}

