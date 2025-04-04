resource "azurerm_monitor_private_link_scope" "law-ampls" {
  name                = "${var.APP_NAME}-${var.ENV}-law-ampls"
  resource_group_name = data.azurerm_resource_group.net-rg.name
}


resource "azurerm_monitor_private_link_scoped_service" "law-ampls-link" {
  name                = "${var.APP_NAME}-${var.ENV}-law-ampls-link"
  resource_group_name = data.azurerm_resource_group.net-rg.name

  scope_name         = azurerm_monitor_private_link_scope.law-ampls.name
  linked_resource_id = azurerm_log_analytics_workspace.law.id

  depends_on = [
    azurerm_monitor_private_link_scope.law-ampls,
    azurerm_log_analytics_workspace.law
  ]
}

