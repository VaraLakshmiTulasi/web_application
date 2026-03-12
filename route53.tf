data "aws_route53_zone" "existing" {
  zone_id = "Z04347413TVJNA0KCMEZ7"
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name    = "learn4.shop"
  type    = "A"

  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name    = "www.learn4.shop"
  type    = "A"

  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}