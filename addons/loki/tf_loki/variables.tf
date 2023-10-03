variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "oidc_provider" {
  description = "OIDC provider for EKS"
  type        = string
}

variable "chart_version" {
  description = "Helm chart repository URL for Grafana Loki"
  type        = string
  default     = "YOUR_LOKI_CHART_REPOSITORY" # Change this to the correct repository URL or provide it when calling the module
}

variable "region" {}
variable "cluster" {}
variable "promtail_chart_version" {
  description = "The chart version for the Promtail Helm chart"
  default     = "some-version" # Update this to the desired version
}

