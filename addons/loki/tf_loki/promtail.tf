resource "kubernetes_service_account" "promtail" {
  metadata {
    name      = "promtail-sa"
    namespace = kubernetes_namespace.logs.id
  }
  automount_service_account_token = true
}

resource "helm_release" "promtail" {
  repository = "https://grafana.github.io/helm-charts"
  chart     = "promtail"
  name      = "promtail"
  version   = var.promtail_chart_version # You might want to define this version in your variables.tf
  namespace = kubernetes_namespace.logs.id

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.promtail.metadata.0.name
  }

  # Setting up the Loki service URL for Promtail to send logs
  set {
    name  = "loki.serviceName"
    value = "loki" # assuming the name of loki service is 'loki'
  }

  # Add other necessary configurations specific to your use case here
}


