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


resource "aws_acm_certificate_validation" "demo" {
  certificate_arn         = aws_acm_certificate.demo.arn
  validation_record_fqdns = [aws_route53_record.demo_validation.fqdn]
}
