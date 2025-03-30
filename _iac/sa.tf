resource "azurerm_storage_account" "iac-sa" {
  name = "${var.APP_NAME}${var.ENV}iacsa"

  resource_group_name = azurerm_resource_group.data-rg.name
  location            = azurerm_resource_group.data-rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false

  depends_on = [
    azurerm_resource_group.data-rg
  ]
}

resource "azurerm_storage_container" "iacsa-tfplan-container" {
  name = "tfplan"

  storage_account_id = azurerm_storage_account.iac-sa.id

  depends_on = [
    azurerm_storage_account.iac-sa
  ]
}

resource "azurerm_storage_container" "iacsa-tfstate-container" {
  name = "tfstate"

  storage_account_id = azurerm_storage_account.iac-sa.id

  depends_on = [
    azurerm_storage_account.iac-sa
  ]
}
