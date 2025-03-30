data "azurerm_virtual_network" "vnet" {
  name                = "${var.APP_NAME}-${var.ENV}-vnet"
  resource_group_name = data.azurerm_resource_group.net-rg.name
}


data "azurerm_subnet" "vnet-infra-subnet" {
  name                 = "${var.APP_NAME}-${var.ENV}-vnet-infra-subnet"
  resource_group_name  = data.azurerm_resource_group.net-rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}
