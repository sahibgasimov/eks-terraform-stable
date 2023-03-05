resource "aws_acm_certificate" "example" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Name   = var.cluster_name
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}