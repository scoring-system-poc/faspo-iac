resource "helm_release" "argocd" {
  name = "${var.APP_NAME}-${var.ENV}-argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace = kubernetes_namespace.aks-argocd-ns.metadata.0.name
  skip_crds = true

  values = [
    yamlencode({
      server = {
        service = {
          type = "ClusterIP"
        }
      }
    })
  ]

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    kubernetes_namespace.aks-argocd-ns
  ]
}


resource "kubernetes_secret" "ghb-apps-deploy-key" {
  metadata {
    name      = "${var.APP_NAME}-${var.ENV}-ghb-apps-deploy-key"
    namespace = kubernetes_namespace.aks-argocd-ns.metadata.0.name
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    ssh-key = base64decode(var.ARGOCD_DEPLOY_KEY)
  }

  type = "Opaque"

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    kubernetes_namespace.aks-argocd-ns
  ]
}


# TODO: ArgoCD project that monitor faspo-apps repo

