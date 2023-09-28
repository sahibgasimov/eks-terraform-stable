provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "eks_blueprints_kubernetes_addons" {
  source                    = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"
  eks_cluster_id            = "dev"
  enable_cluster_autoscaler = true
  cluster_autoscaler_helm_config = {
    version = "9.28.0" ### Visit https://artifacthub.io/packages/helm/cluster-autoscaler/cluster-autoscaler to see latest chart version available when deploying
  }

  enable_metrics_server = true
  metrics_server_helm_config = {
    version = "3.9.0" ### Visit https://artifacthub.io/packages/helm/metrics-server/metrics-server to see latest chart version available when deploying
  }

  enable_aws_cloudwatch_metrics = true
  aws_cloudwatch_metrics_helm_config = {
    version = "0.0.7" ### Visit https://artifacthub.io/packages/helm/aws/aws-cloudwatch-metrics to see latest chart version available when deploying
  }

  enable_aws_for_fluentbit = true
  aws_for_fluentbit_helm_config = {
    version = "0.1.23" ### Visit https://artifacthub.io/packages/helm/aws/aws-for-fluent-bit to see latest chart version available when deploying
  }
}
