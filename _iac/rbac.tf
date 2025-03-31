resource "azurerm_role_assignment" "gha-azsubscr-rbac" {
  principal_id         = azuread_service_principal.gha-app-sp.object_id
  scope                = "/subscriptions/${var.AZURE_SUBSCRIPTION_ID}"
  role_definition_name = "Owner"

  depends_on = [
    azuread_service_principal.gha-app-sp
  ]
}


resource "azurerm_role_assignment" "gha-iacsa-rbac" {
  principal_id         = azuread_service_principal.gha-app-sp.object_id
  scope                = azurerm_storage_account.iac-sa.id
  role_definition_name = "Storage Blob Data Contributor"

  depends_on = [
    azuread_service_principal.gha-app-sp,
    azurerm_storage_account.iac-sa
  ]
}


resource "azuread_directory_role" "app-admin-role" {
  display_name = "Application Administrator"
}


resource "azuread_app_role_assignment" "gha-azdirectory-rbac" {
  role_id            = azuread_directory_role.app-admin-role.id
  principal_id       = azuread_service_principal.gha-app-sp.object_id
  directory_scopy_id = var.AZURE_TENANT_ID
}

