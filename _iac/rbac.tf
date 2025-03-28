resource "azurerm_role_assignment" "gha-azsubscr-rbac" {
  principal_id         = azuread_service_principal.gha-app-sp.object_id
  scope                = "/subscriptions/${var.AZURE_SUBSCRIPTION_ID}"
  role_definition_name = "Contributor"

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
