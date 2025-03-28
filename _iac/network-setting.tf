resource "azapi_resource" "ghb-network-setting" {
  name = "${var.APP_NAME}${var.ENV}ghbns"

  type      = "GitHub.Network/networkSettings@2024-04-02"
  parent_id = azurerm_resource_group.net-rg.id
  location  = azurerm_resource_group.net-rg.location

  body = {
    properties = {
      subnetId   = azurerm_subnet.vnet-subnet-ghb.id
      businessId = var.GHB_DATABASE_ID
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [
    azurerm_resource_group.net-rg,
    azurerm_subnet.vnet-subnet-ghb
  ]
}