provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "aws" {
  region = var.region
}

 provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

 provider "kubectl" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.11" # specify a version if needed
    }
  }
}



resource "aws_s3_bucket" "loki_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_iam_policy" "loki_policy" {
  name_prefix = "loki-policy"
  description = "IAM policy for Loki"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Effect = "Allow",
        Resource = [
          aws_s3_bucket.loki_bucket.arn,
          "${aws_s3_bucket.loki_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "loki_role" {
  name_prefix        = "loki-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${var.oidc_provider}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "${var.oidc_provider}:sub": "system:serviceaccount:logs:loki-sa"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "loki_role_attach" {
  policy_arn = aws_iam_policy.loki_policy.arn
  role = aws_iam_role.loki_role.name
}

resource "kubernetes_namespace" "logs" {
  metadata {
    name = "logs"
  }
}

resource "kubernetes_service_account" "loki" {
metadata {
    name = "loki-sa"
    namespace = kubernetes_namespace.logs.id
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.loki_role.arn
    }
  }
  automount_service_account_token = true
#  depends_on = [kubernetes_namespace.logs]
}

resource "helm_release" "loki" {
  repository = "https://grafana.github.io/helm-charts"
  chart = "loki"
  name = "loki"
  version = var.chart_version
  namespace = kubernetes_namespace.logs.id

  set {
    name = "serviceAccount.create"
    value = "false"
  }

  set {
    name = "serviceAccount.name"
    value = kubernetes_service_account.loki.metadata.0.name
  }

  values = [
    templatefile("../values-local.yaml", {
      iam_role_arn = aws_iam_role.loki_role.arn,
      bucket_name = var.bucket_name
    })
  ]
}

