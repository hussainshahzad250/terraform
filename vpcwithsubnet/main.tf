# 1 : Create a VPC
resource "aws_vpc" "myvpc"{
    cidr_block = var.vpc_cidr
    tags = {
        "Name" = format("%s-%s-%s-myvpc",var.environment,var.clientName,var.product)
    }
}

#  2: Create a public subnet
resource "aws_subnet" "PublicSubnet"{
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "ap-south-1a"
    cidr_block = var.public_subnet_cidr
    tags = {
        "Name" = format("%s-%s-%s-PublicSubnet",var.environment,var.clientName,var.product)
    }
}

#  3 : create a private subnet
resource "aws_subnet" "PrivSubnet"{
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = true

    tags = {
        "Name" = format("%s-%s-%s-PrivSubnet",var.environment,var.clientName,var.product)
    }
}

#  4 : create IGW
resource "aws_internet_gateway" "myIgw"{
    vpc_id = aws_vpc.myvpc.id
    tags = {
        "Name" = format("%s-%s-%s-myIgw",var.environment,var.clientName,var.product)
    }
}

#  5 : route Tables for public subnet
resource "aws_route_table" "PublicRT"{
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
    tags = {
        "Name" = format("%s-%s-%s-PublicRT",var.environment,var.clientName,var.product)
    }
}
 
#  7 : route table association public subnet 
resource "aws_route_table_association" "PublicRTAssociation"{
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRT.id
}
