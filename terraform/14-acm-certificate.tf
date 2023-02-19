resource "aws_acm_certificate" "example" {
  domain_name = var.domain
  validation_method = "DNS"

  tags = {
    Name = "example-cert"
  }
}

output "certificate_arn" {
  value = aws_acm_certificate.example.arn
}
