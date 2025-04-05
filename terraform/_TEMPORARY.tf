# temporary definitions to try out app build and push to ACR

resource "azuread_application" "gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-gha-test-app"
  prevent_duplicate_names = true
}


resource "azuread_service_principal" "gha-app-sp" {
  client_id = azuread_application.gha-app.client_id

  depends_on = [
    azuread_application.gha-app
  ]
}


resource "azuread_application_federated_identity_credential" "gha-app-fc" {
  display_name = "${var.APP_NAME}-${var.ENV}-gha-test-app-fc"

  application_id = azuread_application.gha-app.id

  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:${var.PROJECT_NAME}/test-app:ref:refs/heads/main"
  audiences = ["api://AzureADTokenExchange"]

  depends_on = [
    azuread_application.gha-app
  ]
}


resource "azurerm_role_assignment" "gha-acr-rbac" {
  principal_id         = azuread_service_principal.gha-app-sp.object_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"

  depends_on = [
    azuread_service_principal.gha-app-sp,
    azurerm_container_registry.acr
  ]
}


resource "azurerm_user_assigned_identity" "test-app-uami" {
  name = "${var.APP_NAME}-${var.ENV}-test-app-uami"

  resource_group_name = data.azurerm_resource_group.sec-rg.name
  location            = data.azurerm_resource_group.sec-rg.location
}


data "azurerm_cosmosdb_sql_role_definition" "cosmos-contributor-role" {
  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  role_definition_id  = "00000000-0000-0000-0000-000000000002"

  depends_on = [
    azurerm_cosmosdb_account.cdb
  ]
}


resource "azurerm_cosmosdb_sql_role_assignment" "test-app-cdb-rbac" {
  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  role_definition_id  = data.azurerm_cosmosdb_sql_role_definition.cosmos-contributor-role.id

  principal_id = azurerm_user_assigned_identity.test-app-uami.principal_id
  scope        = azurerm_cosmosdb_account.cdb.id

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_user_assigned_identity.test-app-uami
  ]
}


# TODO: temporary for manual deploymnet (if Argo, then this is not needed)
resource "azurerm_role_assignment" "gha-aks-rbac" {
  principal_id         = azuread_service_principal.gha-app-sp.object_id
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"

  depends_on = [
    azuread_service_principal.gha-app-sp,
    azurerm_kubernetes_cluster.aks
  ]
}

