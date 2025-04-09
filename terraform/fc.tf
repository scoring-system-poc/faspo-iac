resource "azuread_application_federated_identity_credential" "online-data-service-gha-app-fc" {
  display_name = "${var.APP_NAME}-${var.ENV}-online-data-service-gha-fc"

  application_id = azuread_application.online-data-service-gha-app.id

  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:${var.PROJECT_NAME}/${var.APP_NAME}-online-data-service:ref:refs/heads/main"
  audiences = ["api://AzureADTokenExchange"]

  depends_on = [
    azuread_application.online-data-service-gha-app
  ]
}


resource "azuread_application_federated_identity_credential" "batch-data-service-gha-app-fc" {
  display_name = "${var.APP_NAME}-${var.ENV}-batch-data-service-gha-fc"

  application_id = azuread_application.batch-data-service-gha-app.id

  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:${var.PROJECT_NAME}/${var.APP_NAME}-batch-data-service:ref:refs/heads/main"
  audiences = ["api://AzureADTokenExchange"]

  depends_on = [
    azuread_application.batch-data-service-gha-app
  ]
}


resource "azuread_application_federated_identity_credential" "export-service-gha-app-fc" {
  display_name = "${var.APP_NAME}-${var.ENV}-export-service-gha-fc"

  application_id = azuread_application.export-service-gha-app.id

  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:${var.PROJECT_NAME}/${var.APP_NAME}-export-service:ref:refs/heads/main"
  audiences = ["api://AzureADTokenExchange"]

  depends_on = [
    azuread_application.export-service-gha-app
  ]
}


resource "azurerm_federated_identity_credential" "export-service-uami-fc" {
  name                = "${var.APP_NAME}-${var.ENV}-export-service-uami-fc"
  resource_group_name = data.azurerm_resource_group.sec-rg.name

  parent_id = azurerm_user_assigned_identity.export-service-uami.id
  subject   = "system:serviceaccount:${var.APP_NAME}-${var.ENV}-apps:${var.APP_NAME}-${var.ENV}-export-service-sa"

  audience = ["api://AzureADTokenExchange"]
  issuer   = azurerm_kubernetes_cluster.aks.oidc_issuer_url

  depends_on = [
    azurerm_user_assigned_identity.export-service-uami,
    azurerm_kubernetes_cluster.aks
  ]
}


resource "azuread_application_federated_identity_credential" "store-service-gha-app-fc" {
  display_name = "${var.APP_NAME}-${var.ENV}-store-service-gha-fc"

  application_id = azuread_application.store-service-gha-app.id

  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:${var.PROJECT_NAME}/${var.APP_NAME}-store-service:ref:refs/heads/main"
  audiences = ["api://AzureADTokenExchange"]

  depends_on = [
    azuread_application.store-service-gha-app
  ]
}


resource "azuread_application_federated_identity_credential" "model-service-gha-app-fc" {
  display_name = "${var.APP_NAME}-${var.ENV}-model-service-gha-fc"

  application_id = azuread_application.model-service-gha-app.id

  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:${var.PROJECT_NAME}/${var.APP_NAME}-model-service:ref:refs/heads/main"
  audiences = ["api://AzureADTokenExchange"]

  depends_on = [
    azuread_application.model-service-gha-app
  ]
}


resource "azurerm_federated_identity_credential" "store-service-uami-fc" {
  name                = "${var.APP_NAME}-${var.ENV}-store-service-uami-fc"
  resource_group_name = data.azurerm_resource_group.sec-rg.name

  parent_id = azurerm_user_assigned_identity.store-service-uami.id
  subject   = "system:serviceaccount:${var.APP_NAME}-${var.ENV}-apps:${var.APP_NAME}-${var.ENV}-store-service-sa"

  audience = ["api://AzureADTokenExchange"]
  issuer   = azurerm_kubernetes_cluster.aks.oidc_issuer_url

  depends_on = [
    azurerm_user_assigned_identity.store-service-uami,
    azurerm_kubernetes_cluster.aks
  ]
}

