data "azurerm_resource_group" "comp-rg" {
  name = "${var.APP_NAME}-${var.ENV}-comp-rg"
}


data "azurerm_resource_group" "data-rg" {
  name = "${var.APP_NAME}-${var.ENV}-data-rg"
}


data "azurerm_resource_group" "net-rg" {
  name = "${var.APP_NAME}-${var.ENV}-net-rg"
}


data "azurerm_resource_group" "sec-rg" {
  name = "${var.APP_NAME}-${var.ENV}-sec-rg"
}

