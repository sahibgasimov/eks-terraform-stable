terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config" # adjust this to your kubeconfig file
}

resource "kubernetes_namespace" "kubecost" {
  metadata {
    name = "kubecost"
  }
}


resource "helm_release" "kubecost" {
  name       = "kubecost"
  namespace  = "kubecost"
  repository = "https://kubecost.github.io/cost-analyzer"
  chart      = "cost-analyzer"
  version    = "1.104.4" # adjust this to the version you want to use

  values = [
    data.local_file.values.content
  ]

  depends_on = [kubernetes_namespace.kubecost]

}
data "local_file" "values" {
  filename = var.values_file
}
variable "values_file" {
  description = "Path to the values file"
  type        = string
  default     = "./values.yaml"
}
