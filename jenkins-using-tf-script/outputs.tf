output "public_dns" {
  value = aws_instance.jenkins.public_dns
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "key_name" {
  value = aws_instance.jenkins.key_name
}