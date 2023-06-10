# 1 : Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = format("%s-%s-%s-myvpc", var.environment, var.clientName, var.product)
  }
}


#  2: Create a public subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = "ap-south-1a"
  cidr_block        = var.public_subnet_cidr
  tags = {
    "Name" = format("%s-%s-%s-public-db-subnet", var.environment, var.clientName, var.product)
  }
}

# 2 Create an IAM role
resource "aws_iam_role" "example_role" {
  name = "example-role"
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

#securitygroup using Terraform
resource "aws_security_group" "my_sg" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami             = "ami-0f5ee92e2d63afc18"
  instance_type   = "t2.micro"
  key_name        = "test"
  security_groups = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.PublicSubnet.id
  # Attach the IAM role to the EC2 instance
  # iam_instance_profile {
  #   name = aws_iam_role.example_role.name
  # }
  associate_public_ip_address = true

  tags = {
    "Name" = format("%s-%s-%s", var.environment, var.clientName, var.product)
  }
}

