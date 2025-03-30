resource "azurerm_private_endpoint" "iac-sa-pen" {
  name = "${var.APP_NAME}-${var.ENV}-iacsa-pen"

  resource_group_name = azurerm_resource_group.net-rg.name
  location            = azurerm_resource_group.net-rg.location

  subnet_id                     = azurerm_subnet.vnet-infra-subnet.id
  custom_network_interface_name = "${var.APP_NAME}-${var.ENV}-iacsa-pen-nic"

  private_service_connection {
    private_connection_resource_id = azurerm_storage_account.iac-sa.id
    name                           = "iacsa-pen-connection"
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name = "${var.APP_NAME}-${var.ENV}-iacsa-pen-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.iac-sa-pen-dns-zone.id
    ]
  }

  depends_on = [
    azurerm_resource_group.net-rg,
    azurerm_subnet.vnet-infra-subnet,
    azurerm_storage_account.iac-sa
  ]
}

