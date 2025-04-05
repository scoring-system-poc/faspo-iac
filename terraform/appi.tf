resource "azurerm_application_insights" "appi" {
  name = "${var.APP_NAME}-${var.ENV}-appi"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  location            = data.azurerm_resource_group.data-rg.location

  workspace_id     = azurerm_log_analytics_workspace.law.id
  application_type = "other"

  daily_data_cap_in_gb = 10
  retention_in_days    = 30

  internet_ingestion_enabled = false
  internet_query_enabled     = false

  depends_on = [
    azurerm_log_analytics_workspace.law,
    azurerm_monitor_private_link_scope.law-ampls,
    azurerm_monitor_private_link_scoped_service.law-ampls-link
  ]
}

