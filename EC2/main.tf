resource "aws_instance" "web" {
  ami           = var.amiId
  instance_type = "t2.micro"

  tags = {
    "Name" = format("%s-%s-%s",var.environment,var.clientName,var.product)
  }
}