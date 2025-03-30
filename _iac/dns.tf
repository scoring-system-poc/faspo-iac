resource "azurerm_private_dns_zone" "iac-sa-pen-dns-zone" {
  name                = "privatelink.blob.core.windows.net" # important for automatic DNS registration
  resource_group_name = azurerm_resource_group.net-rg.name
}


resource "azurerm_private_dns_zone_virtual_network_link" "iac-sa-pen-dns-zone-vnet-link" {
  name                = "${var.APP_NAME}-${var.ENV}-iacsa-pen-dns-zone-vnet-link"
  resource_group_name = azurerm_resource_group.net-rg.name

  private_dns_zone_name = azurerm_private_dns_zone.iac-sa-pen-dns-zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

