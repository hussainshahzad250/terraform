output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "public_database_subnet_id" {
  value = aws_subnet.PublicSubnet.id
}

output "private_database_subnet_id" {
  value = aws_subnet.PrivSubnet.id
}
