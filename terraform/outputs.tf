output "SomeOutput" {
  value = <<EOF

        Create AWS Kubeconfig                   aws eks --region us-east-1 update-kubeconfig --name demo

        VPC ID                                  ${aws_vpc.main.id}

        Test policy arn                         ${aws_iam_role.test_oidc.arn}

        EKS Cluster autoscaler arn              ${aws_iam_role.eks_cluster_autoscaler.arn}

        AWS LoadBalancer controller arn         ${aws_iam_role.aws_load_balancer_controller.arn}

        ACM Certificate arn                     ${module.cert.arn}

    EOF
}

