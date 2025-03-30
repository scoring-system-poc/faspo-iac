resource "azurerm_user_assigned_identity" "aks-uami" {
  name = "${var.APP_NAME}-${var.ENV}-aks-uami"

  resource_group_name = data.azurerm_resource_group.sec-rg.name
  location            = data.azurerm_resource_group.sec-rg.location
}
