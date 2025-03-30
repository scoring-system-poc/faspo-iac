resource "azurerm_virtual_network" "vnet" {
  name = "${var.APP_NAME}-${var.ENV}-vnet"

  resource_group_name = azurerm_resource_group.net-rg.name
  location            = azurerm_resource_group.net-rg.location

  address_space = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.net-rg
  ]
}


resource "azurerm_subnet" "vnet-ghb-subnet" {
  name = "${var.APP_NAME}-${var.ENV}-vnet-ghb-subnet"

  resource_group_name  = azurerm_resource_group.net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.1.0/24"]

  delegation {
    name = "${var.APP_NAME}-${var.ENV}-ghb-ns-delegation"
    service_delegation {
      name = "GitHub.Network/networkSettings"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }

  depends_on = [
    azurerm_resource_group.net-rg,
    azurerm_virtual_network.vnet
  ]
}


resource "azurerm_subnet" "vnet-infra-subnet" {
  name = "${var.APP_NAME}-${var.ENV}-vnet-infra-subnet"

  resource_group_name  = azurerm_resource_group.net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.2.0/24"]

  depends_on = [
    azurerm_resource_group.net-rg,
    azurerm_virtual_network.vnet
  ]
}

