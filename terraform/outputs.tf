output "SomeOutput" {
  value = <<EOF
###################################### KUBECONFIG ###########################################

        aws eks --region us-east-1 update-kubeconfig --name ${var.cluster_name}

############################# N E T W O R K I N G ###########################################
        VPC ID                                  ${module.aws_eks_cluster.eks.aws_vpc.main.id}
        Public subnet 1                         ${module.aws_eks_cluster.eks.aws_subnet.public-1.id}
        Public subnet 2                         ${module.aws_eks_cluster.eks.aws_subnet.public-2.id}
        Public subnet 3                         ${module.aws_eks_cluster.eks.aws_subnet.public-3.id}
        Private subnet 1                        ${module.aws_eks_cluster.eks.aws_subnet.private-1.id}
        Private subnet 2                        ${module.aws_eks_cluster.eks.aws_subnet.private-2.id}
        Private subnet 3                        ${module.aws_eks_cluster.eks.aws_subnet.private-3.id}
###################################### ALB ASG ACM ##########################################
        EKS Cluster autoscaler role arn         ${module.aws_eks_cluster.eks.aws_iam_role.eks_cluster_autoscaler.arn}
                
        AWS LoadBalancer controller arn         ${module.aws_eks_cluster.eks.aws_iam_role.aws_load_balancer_controller.arn}

        ACM Certificate arn                     ${module.aws_eks_cluster.module.cert.arn}
###################################### EKS Cluster #####################################################

        ${var.cluster_name} EKS Cluster Role    ${module.aws_eks_cluster.aws_iam_role.dev.arn}
        EKS Nodes Group Role                    ${module.aws_eks_cluster.aws_iam_role.nodes.arn}
        EKS OIDC                                ${module.aws_eks_cluster.aws_iam_role.dev_oidc.arn}
        OpenID Connect Provider                 ${module.aws_eks_cluster.aws_iam_openid_connect_provider.eks.url}
    EOF
}
