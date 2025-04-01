resource "azurerm_role_assignment" "aks-network-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-uami.principal_id
  scope                = data.azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"

  depends_on = [
    azurerm_user_assigned_identity.aks-uami
  ]
}


resource "azurerm_role_assignment" "aks-acr-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-uami.principal_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"

  depends_on = [
    azurerm_user_assigned_identity.aks-uami,
    azurerm_container_registry.acr
  ]
}


resource "azurerm_role_assignment" "aks-dns-read-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-uami.principal_id
  scope                = azurerm_private_dns_zone.aks-pen-dns-zone.id
  role_definition_name = "Reader"

  depends_on = [
    azurerm_user_assigned_identity.aks-uami,
    azurerm_private_dns_zone.aks-pen-dns-zone
  ]
}


resource "azurerm_role_assignment" "aks-dns-write-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-uami.principal_id
  scope                = azurerm_private_dns_zone.aks-pen-dns-zone.id
  role_definition_name = "Private DNS Zone Contributor"

  depends_on = [
    azurerm_user_assigned_identity.aks-uami,
    azurerm_private_dns_zone.aks-pen-dns-zone
  ]
}

