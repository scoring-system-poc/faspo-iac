resource "azurerm_federated_identity_credential" "test-app-uami-fc" {
  name                = "${var.APP_NAME}-${var.ENV}-test-app-uami-fc"
  resource_group_name = data.azurerm_resource_group.sec-rg.name

  parent_id = azurerm_user_assigned_identity.test-app-uami.id
  subject   = "system:serviceaccount:default:${var.APP_NAME}-${var.ENV}-test-app-sa"

  audience  = ["api://AzureADTokenExchange"]
  issuer    = azurerm_kubernetes_cluster.aks.oidc_issuer_url

  depends_on = [
    azurerm_user_assigned_identity.test-app-uami,
    azurerm_kubernetes_cluster.aks
  ]
}

