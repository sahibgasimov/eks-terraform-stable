module "cert" {
  source = "github.com/azavea/terraform-aws-acm-certificate"


  domain_name                       = var.domain
  subject_alternative_names         = ["*.var.domain"]
  hosted_zone_id                    = "${aws_route53_zone.default.zone_id}"
  validation_record_ttl             = "60"
  allow_validation_record_overwrite = true
}
