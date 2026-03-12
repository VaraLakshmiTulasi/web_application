resource "aws_lb" "app_lb" {
  name               = "my-app-loadbalancer"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public-subnets[*].id
}


