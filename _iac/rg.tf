resource "azurerm_resource_group" "net-rg" {
  name     = "${var.APP_NAME}-${var.ENV}-net-rg"
  location = var.AZURE_LOCATION
}

resource "azurerm_resource_group" "data-rg" {
  name     = "${var.APP_NAME}-${var.ENV}-data-rg"
  location = var.AZURE_LOCATION
}

resource "azurerm_resource_group" "sec-rg" {
  name     = "${var.APP_NAME}-${var.ENV}-sec-rg"
  location = var.AZURE_LOCATION
}

resource "azurerm_resource_group" "comp-rg" {
  name     = "${var.APP_NAME}-${var.ENV}-comp-rg"
  location = var.AZURE_LOCATION
}
