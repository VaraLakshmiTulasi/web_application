resource "aws_lb_target_group_attachment" "app_attachment" {
  count            = 3
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.public_servers[count.index].id
  port             = 80
}