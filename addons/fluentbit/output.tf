output "fluentbit_policy_arn" {
  description = "The ARN of the Fluentbit IAM policy."
  value       = aws_iam_policy.fluentbit.arn
}

output "fluentbit_role_name" {
  description = "The name of the Fluentbit IAM role."
  value       = aws_iam_role.fluentbit-role.name
}

output "fluentbit_role_arn" {
  description = "The ARN of the Fluentbit IAM role."
  value       = aws_iam_role.fluentbit-role.arn
}

output "fluentbit_service_account_name" {
  description = "The name of the Fluentbit Kubernetes service account."
  value       = kubernetes_service_account.fluentbit.metadata.0.name
}

output "fluentbit_service_account_namespace" {
  description = "The namespace of the Fluentbit Kubernetes service account."
  value       = kubernetes_service_account.fluentbit.metadata.0.namespace
}

output "helm_release_fluentbit_version" {
  description = "The version of the Fluentbit Helm release."
  value       = helm_release.logs.version
}

output "helm_release_fluentbit_status" {
  description = "The status of the Fluentbit Helm release."
  value       = helm_release.logs.status
}
