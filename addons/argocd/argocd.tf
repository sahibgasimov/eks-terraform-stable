 provider "helm" {
   kubernetes {
     host                   = aws_eks_cluster.dev.endpoint
     cluster_ca_certificate = base64decode(aws_eks_cluster.dev.certificate_authority[0].data)
     exec {
       api_version = "client.authentication.k8s.io/v1beta1"
       args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.dev.id]
       command     = "aws"
     }
   }
 }

# helm install argocd -n argocd --create-namespace argo/argo-cd --version 3.35.4 -f terraform/values/argocd.yaml
resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "3.35.4"

  values = [file("values/argocd.yaml")]
}
