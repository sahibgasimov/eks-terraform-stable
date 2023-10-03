output "loki_bucket_arn" {
  value = aws_s3_bucket.loki_bucket.arn
}

output "loki_role_arn" {
  value = aws_iam_role.loki_role.arn
}

