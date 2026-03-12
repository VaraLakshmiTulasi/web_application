resource "aws_lb_listener_rule" "app_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  condition {
    host_header {
      values = ["learn4.shop"]
    }
  }
}