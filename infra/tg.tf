resource "aws_lb_target_group" "example_target_group" {
  name     = "example-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path        = "/"
    port        = "traffic-port"
    protocol    = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout     = 3
    interval    = 30
  }
}

resource "aws_lb_target_group_attachment" "example_attachment" {
  
  /* count = 2 */
  /* target_id        = aws_instance.example_instances[count.index].id */
  target_id        = aws_instance.example_instance.id
  target_group_arn = aws_lb_target_group.example_target_group.arn
  port             = 80
}