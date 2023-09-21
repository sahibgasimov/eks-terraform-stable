provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "aws_iam_policy" "fluentbit" {
  name_prefix = "${var.infra_id}-${var.env}-fluentbit-policy"
  description = "IAM policy for fluentbit"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "fluentBitLogManagement",
        Action = [
          "logs:PutLogEvents",
          "logs:Describe*",
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutRetentionPolicy"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "fluentbit-role" {
  name_prefix        = "fluentbit"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.dev.identity.0.oidc.0.issuer, "https://", "")}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "${replace(data.aws_eks_cluster.dev.identity.0.oidc.0.issuer, "https://", "")}:sub": "system:serviceaccount:logs:fluentbit-sa"
        }
      }
    }
  ]
}
EOF
}



resource "aws_iam_role_policy_attachment" "fluentbit" {
  policy_arn = aws_iam_policy.fluentbit.arn
  role       = aws_iam_role.fluentbit-role.name
}

resource "kubernetes_namespace" "logs" {
  metadata {
    name = "logs"
  }
}

resource "kubernetes_service_account" "fluentbit" {
  metadata {
    name      = "fluentbit-sa"
    namespace = kubernetes_namespace.logs.id
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.fluentbit-role.arn
    }
  }

  automount_service_account_token = true
  depends_on                      = [kubernetes_namespace.logs]
}

resource "helm_release" "logs" {
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-for-fluent-bit"
  version    = "0.1.28" # (17 nov, 2022) # https://artifacthub.io/packages/helm/aws/aws-for-fluent-bit
  name       = "aws-fluent-bit"
  namespace  = kubernetes_namespace.logs.id

  values = [
    templatefile("./aws-fluentbit.tpl", {
      logGroupName = var.cluster,
      region       = var.region
    })
  ]

  depends_on = [kubernetes_namespace.logs]
}
