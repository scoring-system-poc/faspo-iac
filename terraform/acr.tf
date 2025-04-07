resource "azurerm_container_registry" "acr" {
  name = "${var.APP_NAME}${var.ENV}acr"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  location            = data.azurerm_resource_group.data-rg.location

  sku                           = "Premium" # required for vNet integration
  public_network_access_enabled = false
}


data "azurerm_container_registry_scope_map" "acr-pull-scope-map" {
  resource_group_name     = data.azurerm_resource_group.data-rg.name
  container_registry_name = azurerm_container_registry.acr.name
  name                    = "_repositories_pull"

  depends_on = [
    azurerm_container_registry.acr
  ]
}


resource "azurerm_container_registry_token" "argocd-acr-token" {
  name = "${var.APP_NAME}-${var.ENV}-argocd-acr-token"

  resource_group_name     = data.azurerm_resource_group.data-rg.name
  container_registry_name = azurerm_container_registry.acr.name

  scope_map_id = data.azurerm_container_registry_scope_map.acr-pull-scope-map.id

  depends_on = [
    azurerm_container_registry.acr
  ]
}


resource "azurerm_container_registry_token_password" "argocd-acr-token-pwd" {
  container_registry_token_id = azurerm_container_registry_token.argocd-acr-token.id

  password1 {}
  password2 {}

  depends_on = [
    azurerm_container_registry_token.argocd-acr-token
  ]
}

