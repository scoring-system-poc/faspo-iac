resource "helm_release" "argocd" {
  name = "${var.APP_NAME}-${var.ENV}-argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace = kubernetes_namespace.aks-argocd-ns.metadata.0.name

  values = [
    yamlencode({
      crds = {
        additionalLabels = {
          "argocd.argoproj.io/managed-by" = kubernetes_namespace.aks-argocd-ns.metadata.0.name
        }
      }
      configs = {
        cm = {
          "admin.enabled"                = "true" # only for testing
          "application.instanceLabelKey" = "app.kubernetes.io/instance"
          "timeout.reconciliation"       = "60s"
        }
        repositories = {
          git = {
            type          = "git"
            name          = "${var.APP_NAME}-apps"
            url           = "git@github.com:${var.PROJECT_NAME}/${var.APP_NAME}-apps.git"
            sshPrivateKey = base64decode(var.ARGOCD_DEPLOY_KEY)
          }
          helm = {
            type      = "helm"
            name      = azurerm_container_registry.acr.name
            url       = "oci://${azurerm_container_registry.acr.name}.azurecr.io/helm"
            username  = "argocd"
            password  = azurerm_container_registry_token_password.argocd-acr-token-pwd.password1.0.value
            enableOCI = "true"
          }
        }
      }
      extraObjects = [
        {
          apiVersion = "argoproj.io/v1alpha1"
          kind       = "Application"
          metadata = {
            name      = "${var.APP_NAME}-apps"
            namespace = kubernetes_namespace.aks-argocd-ns.metadata.0.name
            finalizers = [
              "resources-finalizer.argocd.argoproj.io"
            ]
          }
          spec = {
            project = "default"
            source = {
              repoURL        = "git@github.com:${var.PROJECT_NAME}/${var.APP_NAME}-apps.git"
              targetRevision = "env/${var.ENV}"
              path           = "."
            }
            destination = {
              server    = "https://kubernetes.default.svc"
              namespace = kubernetes_namespace.aks-argocd-ns.metadata.0.name
            }
            syncPolicy = {
              automated = {
                prune    = true
                selfHeal = true
              }
            }
          }
        }
      ]
    })
  ]

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azurerm_container_registry.acr,
    azurerm_container_registry_token_password.argocd-acr-token-pwd,
    kubernetes_namespace.aks-argocd-ns
  ]
}

