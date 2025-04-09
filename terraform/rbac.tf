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


resource "azurerm_role_assignment" "batch-data-service-gha-acr-rbac" {
  principal_id         = azuread_service_principal.batch-data-service-gha-sp.object_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"

  depends_on = [
    azuread_service_principal.batch-data-service-gha-sp,
    azurerm_container_registry.acr
  ]
}


resource "azurerm_role_assignment" "export-service-gha-acr-rbac" {
  principal_id         = azuread_service_principal.export-service-gha-sp.object_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"

  depends_on = [
    azuread_service_principal.export-service-gha-sp,
    azurerm_container_registry.acr
  ]
}


resource "azurerm_role_assignment" "store-service-gha-acr-rbac" {
  principal_id         = azuread_service_principal.store-service-gha-sp.object_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"

  depends_on = [
    azuread_service_principal.store-service-gha-sp,
    azurerm_container_registry.acr
  ]
}


resource "azurerm_cosmosdb_sql_role_assignment" "export-service-cdb-rbac" {
  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  role_definition_id  = data.azurerm_cosmosdb_sql_role_definition.cosmos-reader-role.id

  principal_id = azurerm_user_assigned_identity.export-service-uami.principal_id
  scope        = azurerm_cosmosdb_account.cdb.id

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_user_assigned_identity.store-service-uami
  ]
}


resource "azurerm_cosmosdb_sql_role_assignment" "store-service-cdb-rbac" {
  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  role_definition_id  = data.azurerm_cosmosdb_sql_role_definition.cosmos-contributor-role.id

  principal_id = azurerm_user_assigned_identity.store-service-uami.principal_id
  scope        = azurerm_cosmosdb_account.cdb.id

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_user_assigned_identity.store-service-uami
  ]
}

