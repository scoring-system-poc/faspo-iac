resource "azurerm_kubernetes_cluster" "aks" {
  name = "${var.APP_NAME}-${var.ENV}-aks"

  resource_group_name = data.azurerm_resource_group.comp-rg.name
  location            = data.azurerm_resource_group.comp-rg.location

  node_resource_group = "${var.APP_NAME}-${var.ENV}-aks-nodes-rg"

  dns_prefix_private_cluster = "${var.APP_NAME}-${var.ENV}-aks-dns"
  private_dns_zone_id        = azurerm_private_dns_zone.aks-pen-dns-zone.id

  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  sku_tier = "Free" # only for testing on private account (to minimize cost)

  azure_active_directory_role_based_access_control {
    tenant_id          = var.AZURE_TENANT_ID
    azure_rbac_enabled = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks-cp-uami.id]
  }

  kubelet_identity {
    client_id                 = azurerm_user_assigned_identity.aks-nodepool-uami.client_id
    object_id                 = azurerm_user_assigned_identity.aks-nodepool-uami.principal_id
    user_assigned_identity_id = azurerm_user_assigned_identity.aks-nodepool-uami.id
  }

  default_node_pool {
    name    = "default"
    vm_size = "Standard_B2als_v2" # only for testing on private account (to minimize cost)
    os_sku  = "Ubuntu"

    auto_scaling_enabled        = true
    temporary_name_for_rotation = "rotation"
    min_count                   = 2
    max_count                   = 10

    vnet_subnet_id = data.azurerm_subnet.vnet-infra-subnet.id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    service_cidr   = "10.0.3.0/24"
    dns_service_ip = "10.0.3.254"
  }

  lifecycle {
    ignore_changes = [
      default_node_pool.0.node_count,
      default_node_pool.0.upgrade_settings,
    ]
  }

  depends_on = [
    azurerm_user_assigned_identity.aks-cp-uami,
    azurerm_user_assigned_identity.aks-nodepool-uami,
    azurerm_role_assignment.aks-cp-network-rbac,
    azurerm_role_assignment.aks-cp-dns-read-rbac,
    azurerm_role_assignment.aks-cp-dns-write-rbac,
    azurerm_role_assignment.aks-cp-uami-rbac
  ]
}


resource "kubernetes_namespace" "aks-apps-ns" {
  metadata {
    name = "${var.APP_NAME}-${var.ENV}-apps"
  }
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}


resource "kubernetes_namespace" "aks-argocd-ns" {
  metadata {
    name = "${var.APP_NAME}-${var.ENV}-argocd"
  }
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

