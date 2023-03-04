resource "aws_acm_certificate" "example" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [aws_route53_record.example.fqdn]
}

resource "aws_route53_record" "example" {
  name    = aws_acm_certificate.example.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.example.domain_validation_options[0].resource_record_type
  zone_id = aws_route53_zone.example.zone_id
  records = [aws_acm_certificate.example.domain_validation_options[0].resource_record_value]
  ttl     = 60

  depends_on = [aws_acm_certificate.example]
}

resource "aws_route53_zone" "example" {
  name = var.domain
}
