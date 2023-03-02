#resource "aws_acm_certificate" "example" {
 # domain_name = var.domain
  #validation_method = "DNS"

  #tags = {
  #  Name = "example-cert"
  #}
#}

#output "certificate_arn" {
 # value = aws_acm_certificate.example.arn
#}


resource "aws_route53_zone" "hello_world_zone" {
  name = var.domain
}
resource "aws_acm_certificate" "hello_certificate" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = var.domain
  }
}

resource "aws_route53_record" "hello_cert_dns" {
  allow_overwrite = true
  name =  tolist(aws_acm_certificate.hello_certificate.domain_validation_options)[0].resource_record_name
  records = [tolist(aws_acm_certificate.hello_certificate.domain_validation_options)[0].resource_record_value]
  type = tolist(aws_acm_certificate.hello_certificate.domain_validation_options)[0].resource_record_type
  zone_id = aws_route53_zone.hello_world_zone.zone_id
  ttl = 60
}

resource "aws_acm_certificate_validation" "hello_cert_validate" {
  certificate_arn = aws_acm_certificate.hello_certificate.arn
  validation_record_fqdns = [aws_route53_record.hello_cert_dns.fqdn]
}
