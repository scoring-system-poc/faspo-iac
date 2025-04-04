resource "azurerm_log_analytics_workspace" "law" {
  name = "${var.APP_NAME}-${var.ENV}-law"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  location            = data.azurerm_resource_group.data-rg.location

  sku               = "PerGB2018"
  retention_in_days = 30

  allow_resource_only_permissions = true
  internet_ingestion_enabled      = false
  internet_query_enabled          = false
}

