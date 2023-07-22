output "dns_name" {
  value = aws_lb.example_lb.dns_name
}

output "public_dns" {
    value = aws_instance.example_instance.public_dns
}

output "public_ip" {
    value = aws_instance.example_instance.public_ip
}