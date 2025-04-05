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

