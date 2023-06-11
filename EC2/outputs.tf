output "public_dns" {
  value = aws_instance.web.public_dns
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "key_name" {
  value = aws_instance.web.key_name
}