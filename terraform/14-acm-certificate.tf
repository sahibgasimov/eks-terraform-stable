resource "aws_acm_certificate" "demo" {
  domain_name       = var.domain
  validation_method = "DNS"
  
  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "example_validation" {
  name    = aws_acm_certificate.demo.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.demo.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.demo.zone_id
  records = [aws_acm_certificate.demo.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

data "aws_route53_zone" "demo" {
  name = var.domain
}

resource "aws_acm_certificate_validation" "demo" {
  certificate_arn         = aws_acm_certificate.demo.arn
  validation_record_fqdns = [aws_route53_record.demo_validation.fqdn]
}
