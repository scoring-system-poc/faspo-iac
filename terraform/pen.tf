resource "azurerm_private_endpoint" "acr-pen" {
  name = "${var.APP_NAME}-${var.ENV}-acr-pen"

  resource_group_name = data.azurerm_resource_group.net-rg.name
  location            = data.azurerm_resource_group.net-rg.location

  subnet_id                     = data.azurerm_subnet.vnet-infra-subnet.id
  custom_network_interface_name = "${var.APP_NAME}-${var.ENV}-acr-pen-nic"

  private_service_connection {
    private_connection_resource_id = azurerm_container_registry.acr.id
    name                           = "acr-pen-connection"
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = "${var.APP_NAME}-${var.ENV}-acr-pen-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr-pen-dns-zone.id]
  }

  depends_on = [
    azurerm_container_registry.acr,
    azurerm_private_dns_zone.acr-pen-dns-zone
  ]
}


resource "azurerm_private_endpoint" "aks-pen" {
  name = "${var.APP_NAME}-${var.ENV}-aks-pen"

  resource_group_name = data.azurerm_resource_group.net-rg.name
  location            = data.azurerm_resource_group.net-rg.location

  subnet_id                     = data.azurerm_subnet.vnet-infra-subnet.id
  custom_network_interface_name = "${var.APP_NAME}-${var.ENV}-aks-pen-nic"

  private_service_connection {
    private_connection_resource_id = azurerm_kubernetes_cluster.aks.id
    name                           = "aks-pen-connection"
    is_manual_connection           = false
    subresource_names              = ["management"]
  }

  private_dns_zone_group {
    name = "${var.APP_NAME}-${var.ENV}-aks-pen-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.aks-pen-dns-zone.id
    ]
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azurerm_private_dns_zone.aks-pen-dns-zone
  ]
}


resource "azurerm_private_endpoint" "cdb-pen" {
  name = "${var.APP_NAME}-${var.ENV}-cdb-pen"

  resource_group_name = data.azurerm_resource_group.net-rg.name
  location            = data.azurerm_resource_group.net-rg.location

  subnet_id                     = data.azurerm_subnet.vnet-infra-subnet.id
  custom_network_interface_name = "${var.APP_NAME}-${var.ENV}-cdb-pen-nic"

  private_service_connection {
    private_connection_resource_id = azurerm_cosmosdb_account.cdb.id
    name                           = "cdb-pen-connection"
    is_manual_connection           = false
    subresource_names              = ["SQL"]
  }

  private_dns_zone_group {
    name = "${var.APP_NAME}-${var.ENV}-cdb-pen-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.cdb-pen-dns-zone.id
    ]
  }

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_private_dns_zone.cdb-pen-dns-zone
  ]
}


resource "azurerm_private_endpoint" "law-ampls-pen" {
  name = "${var.APP_NAME}-${var.ENV}-law-ampls-pen"

  resource_group_name = data.azurerm_resource_group.net-rg.name
  location            = data.azurerm_resource_group.net-rg.location

  subnet_id                     = data.azurerm_subnet.vnet-infra-subnet.id
  custom_network_interface_name = "${var.APP_NAME}-${var.ENV}-law-ampls-pen-nic"

  private_service_connection {
    private_connection_resource_id = azurerm_monitor_private_link_scope.law-ampls.id
    name                           = "law-ampls-pen-connection"
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "${var.APP_NAME}-${var.ENV}-law-ampls-pen-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.law-ampls-pen-dns-zone.id
    ]
  }

  depends_on = [
    azurerm_log_analytics_workspace.law,
    azurerm_private_dns_zone.law-ampls-pen-dns-zone
  ]
}

