resource "azurerm_container_registry" "acr" {
  name = "${var.APP_NAME}${var.ENV}acr"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  location            = data.azurerm_resource_group.data-rg.location

  sku                           = "Premium" # required for vNet integration
  public_network_access_enabled = false
}

