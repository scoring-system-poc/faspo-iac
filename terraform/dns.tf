resource "azurerm_private_dns_zone" "acr-pen-dns-zone" {
  name                = "germanywestcentral.data.privatelink.azurecr.io"
  resource_group_name = data.azurerm_resource_group.net-rg.name
}


resource "azurerm_private_dns_zone" "aks-pen-dns-zone" {
  name                = "privatelink.germanywestcentral.azmk8s.io"
  resource_group_name = data.azurerm_resource_group.net-rg.name
}


resource "azurerm_private_dns_zone" "cdb-pen-dns-zone" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = data.azurerm_resource_group.net-rg.name
}


resource "azurerm_private_dns_zone_virtual_network_link" "acr-pen-dns-zone-vnet-link" {
  name                = "${var.APP_NAME}-${var.ENV}-acr-pen-dns-zone-vnet-link"
  resource_group_name = data.azurerm_resource_group.net-rg.name

  private_dns_zone_name = azurerm_private_dns_zone.acr-pen-dns-zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.acr-pen-dns-zone
  ]
}


resource "azurerm_private_dns_zone_virtual_network_link" "aks-pen-dns-zone-vnet-link" {
  name                = "${var.APP_NAME}-${var.ENV}-aks-pen-dns-zone-vnet-link"
  resource_group_name = data.azurerm_resource_group.net-rg.name

  private_dns_zone_name = azurerm_private_dns_zone.aks-pen-dns-zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.aks-pen-dns-zone
  ]
}


resource "azurerm_private_dns_zone_virtual_network_link" "cdb-pen-dns-zone-vnet-link" {
  name                = "${var.APP_NAME}-${var.ENV}-cdb-pen-dns-zone-vnet-link"
  resource_group_name = data.azurerm_resource_group.net-rg.name

  private_dns_zone_name = azurerm_private_dns_zone.cdb-pen-dns-zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.cdb-pen-dns-zone
  ]
}


resource "azurerm_private_dns_a_record" "acr-pen-nic-dns-a-record" {
  name                = azurerm_container_registry.acr.name
  resource_group_name = data.azurerm_resource_group.net-rg.name

  zone_name = azurerm_private_dns_zone.acr-pen-dns-zone.name
  records   = [azurerm_private_endpoint.acr-pen.private_service_connection.0.private_ip_address]
  ttl       = 10

  depends_on = [
    azurerm_container_registry.acr,
    azurerm_private_dns_zone.acr-pen-dns-zone,
    azurerm_private_endpoint.acr-pen
  ]
}


resource "azurerm_private_dns_a_record" "aks-pen-nic-dns-a-record" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = data.azurerm_resource_group.net-rg.name

  zone_name = azurerm_private_dns_zone.aks-pen-dns-zone.name
  records   = [azurerm_private_endpoint.aks-pen.private_service_connection.0.private_ip_address]
  ttl       = 10

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azurerm_private_dns_zone.aks-pen-dns-zone,
    azurerm_private_endpoint.aks-pen
  ]
}



