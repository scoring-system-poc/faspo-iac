resource "azurerm_monitor_private_link_scope" "monitor-ampls" {
  name                = "${var.APP_NAME}-${var.ENV}-monitor-ampls"
  resource_group_name = data.azurerm_resource_group.net-rg.name
}


resource "azurerm_monitor_private_link_scoped_service" "monitor-ampls-law-link" {
  name                = "${var.APP_NAME}-${var.ENV}-monitor-ampls-law-link"
  resource_group_name = data.azurerm_resource_group.net-rg.name

  scope_name         = azurerm_monitor_private_link_scope.monitor-ampls.name
  linked_resource_id = azurerm_log_analytics_workspace.law.id

  depends_on = [
    azurerm_monitor_private_link_scope.monitor-ampls,
    azurerm_log_analytics_workspace.law
  ]
}


resource "azurerm_monitor_private_link_scoped_service" "monitor-ampls-appi-link" {
  name                = "${var.APP_NAME}-${var.ENV}-monitor-ampls-appi-link"
  resource_group_name = data.azurerm_resource_group.net-rg.name

  scope_name         = azurerm_monitor_private_link_scope.monitor-ampls.name
  linked_resource_id = azurerm_application_insights.appi.id

  depends_on = [
    azurerm_monitor_private_link_scope.monitor-ampls,
    azurerm_application_insights.appi
  ]
}

