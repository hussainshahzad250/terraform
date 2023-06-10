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

#  3 : create a private subnet
resource "aws_subnet" "PrivSubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    "Name" = format("%s-%s-%s-private-db-subnet", var.environment, var.clientName, var.product)
  }
}

# create security group for the web server
resource "aws_security_group" "webserver_security_group" {
  name        = "webserver security group"
  description = "enable http access on port 80"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = format("%s-%s-%s-webserver-sg", var.environment, var.clientName, var.product)
  }
}

# create security group for the database
resource "aws_security_group" "db_security_group" {
  name        = "database security group"
  description = "enable mysql/aurora access on port 3306"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description     = "mysql/aurora access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = format("%s-%s-%s-db_sg", var.environment, var.clientName, var.product)
  }
}

# This section allow you to access DB from out side from any IP
# resource "aws_security_group_rule" "rds_ingress_rule" {
#   security_group_id = aws_security_group.db_security_group.id
#   type              = "ingress"
#   from_port         = 3306
#   to_port           = 3306
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }



# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "database-subnets"
  subnet_ids  = [aws_subnet.PublicSubnet.id, aws_subnet.PrivSubnet.id]
  description = "subnets for database instance"

  tags = {
    "Name" = format("%s-%s-%s-db_subnet-group", var.environment, var.clientName, var.product)
  }
}




# create the rds instance
resource "aws_db_instance" "db_instance" {

  engine                 = "mysql"
  engine_version         = "8.0.32"
  multi_az               = false
  identifier             = "dev-rds-instance"
  username               = "root"
  password               = "rootuser123"
  instance_class         = "db.t2.micro"
  allocated_storage      = 200
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  availability_zone      = "ap-south-1a"
  # db_name                = "developmentdb"
  skip_final_snapshot = true


}


