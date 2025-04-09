resource "azurerm_user_assigned_identity" "aks-cp-uami" {
  name = "${var.APP_NAME}-${var.ENV}-aks-cp-uami"

  resource_group_name = data.azurerm_resource_group.sec-rg.name
  location            = data.azurerm_resource_group.sec-rg.location
}


resource "azurerm_user_assigned_identity" "aks-nodepool-uami" {
  name = "${var.APP_NAME}-${var.ENV}-aks-nodepool-uami"

  resource_group_name = data.azurerm_resource_group.sec-rg.name
  location            = data.azurerm_resource_group.sec-rg.location
}


resource "azurerm_user_assigned_identity" "export-service-uami" {
  name = "${var.APP_NAME}-${var.ENV}-export-service-uami"

  resource_group_name = data.azurerm_resource_group.sec-rg.name
  location            = data.azurerm_resource_group.sec-rg.location
}


resource "azurerm_user_assigned_identity" "store-service-uami" {
  name = "${var.APP_NAME}-${var.ENV}-store-service-uami"

  resource_group_name = data.azurerm_resource_group.sec-rg.name
  location            = data.azurerm_resource_group.sec-rg.location
}


resource "azurerm_user_assigned_identity" "request-handler-uami" {
  name = "${var.APP_NAME}-${var.ENV}-request-handler-uami"

  resource_group_name = data.azurerm_resource_group.sec-rg.name
  location            = data.azurerm_resource_group.sec-rg.location
}

