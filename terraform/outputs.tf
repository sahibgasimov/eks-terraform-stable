output "SomeOutput" {
  value = <<EOF

        Create AWS Kubeconfig                   aws eks --region us-east-1 update-kubeconfig --name demo

        VPC ID                                  ${aws_vpc.main.id}

        Test policy arn                         ${aws_iam_role.dev_oidc.arn}

        EKS Cluster autoscaler role arn         ${aws_iam_role.eks_cluster_autoscaler.arn}
        
        EKS Cluster autoscaler arn              ${data.aws_autoscaling_group.node_group.arn}
        
        AWS LoadBalancer controller arn         ${aws_iam_role.aws_load_balancer_controller.arn}

        ACM Certificate arn                     ${module.cert.arn}
        
        
    EOF
}



