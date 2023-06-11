resource "aws_instance" "web" {
  ami           = var.amiId
  instance_type = "t2.micro"
  # count         = 5       // meta argument
  key_name = "test"
  # security_groups = ["security group using Terraform"]

  tags = {
    "Name" = format("%s-%s-%s", var.environment, var.clientName, var.product)
  }
}
