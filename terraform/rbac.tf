resource "azurerm_role_assignment" "aks-cp-network-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-cp-uami.principal_id
  scope                = data.azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"

  depends_on = [
    azurerm_user_assigned_identity.aks-cp-uami
  ]
}


resource "azurerm_role_assignment" "aks-cp-dns-read-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-cp-uami.principal_id
  scope                = azurerm_private_dns_zone.aks-pen-dns-zone.id
  role_definition_name = "Reader"

  depends_on = [
    azurerm_user_assigned_identity.aks-cp-uami,
    azurerm_private_dns_zone.aks-pen-dns-zone
  ]
}


resource "azurerm_role_assignment" "aks-cp-dns-write-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-cp-uami.principal_id
  scope                = azurerm_private_dns_zone.aks-pen-dns-zone.id
  role_definition_name = "Private DNS Zone Contributor"

  depends_on = [
    azurerm_user_assigned_identity.aks-cp-uami,
    azurerm_private_dns_zone.aks-pen-dns-zone
  ]
}


resource "azurerm_role_assignment" "aks-cp-uami-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-cp-uami.principal_id
  scope                = azurerm_user_assigned_identity.aks-nodepool-uami.id
  role_definition_name = "Managed Identity Operator"

  depends_on = [
    azurerm_user_assigned_identity.aks-cp-uami,
    azurerm_user_assigned_identity.aks-nodepool-uami
  ]
}


resource "azurerm_role_assignment" "aks-nodepool-acr-rbac" {
  principal_id         = azurerm_user_assigned_identity.aks-nodepool-uami.principal_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"

  depends_on = [
    azurerm_user_assigned_identity.aks-nodepool-uami,
    azurerm_container_registry.acr
  ]
}

