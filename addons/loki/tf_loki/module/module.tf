module "loki" {
  source        = "../" # Path to the module folder
  bucket_name   = "sdsdsd-sah-loki-object-store"
  oidc_provider = "arn:aws:iam:::oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/F488F53EF1EB2C667F162F94D29E7337"
  chart_version = "5.22"
  promtail_chart_version = "6.15"
  cluster       = "dev"
  region        = "us-east-1"
}

