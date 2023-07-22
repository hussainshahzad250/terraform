
resource "aws_instance" "example_instance" {
  ami                         = "ami-072ec8f4ea4a6f2cf"
  instance_type               = "t2.micro"
  key_name                    = "test"
  security_groups             = [aws_security_group.my_sg.id]
  subnet_id                   = aws_subnet.PublicSubnet.id
  associate_public_ip_address = true

  tags = {
    "Name" = format("%s-%s-%s", var.environment, var.clientName, var.product)
  }
}

resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.example_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.example_target_group.arn
    type             = "forward"
  }
}