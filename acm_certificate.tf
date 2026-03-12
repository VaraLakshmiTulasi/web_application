# resource "aws_acm_certificate" "app_cert" {
#   domain_name       = "learn4.shop"
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # Validate the cerificate
# resource "aws_acm_certificate_validation" "app_cert_validation" {
#   certificate_arn = aws_acm_certificate.app_cert.arn
#   validation_record_fqdns = [
#     for record in aws_route53_record.cert_validation : record.fqdn
#   ]
# }

# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.app_cert.domain_validation_options :
#     dvo.domain_name => dvo
#   }

#   zone_id = aws_route53_zone.default.zone_id
#   name    = each.value.resource_record_name
#   type    = each.value.resource_record_type
#   records = [each.value.resource_record_value]
#   ttl     = 60
# }