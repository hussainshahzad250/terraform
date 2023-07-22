resource "aws_lb" "example_lb" {
  name               = "example-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  /* subnets            = [aws_subnet.PublicSubnet.id, aws_subnet.PrivSubnet.id] */
  

  subnet_mapping {
    subnet_id = aws_subnet.PublicSubnet.id  # Replace with your desired public subnet ID
    /* allocation_id = "eipalloc-01234567"  # Replace with your Elastic IP allocation ID */
  }

  subnet_mapping {
    subnet_id = aws_subnet.PrivSubnet.id  # Replace with your subnet ID
    /* allocation_id = "eipalloc-98765432"  # Replace with your Elastic IP allocation ID */
  }
}