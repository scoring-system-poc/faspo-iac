resource "azurerm_kubernetes_cluster" "aks" {
  name = "${var.APP_NAME}-${var.ENV}-aks"

  resource_group_name = data.azurerm_resource_group.comp-rg.name
  location            = data.azurerm_resource_group.comp-rg.location

  node_resource_group                 = "${var.APP_NAME}-${var.ENV}-aks-nodes-rg"
  dns_prefix                          = "${var.APP_NAME}-${var.ENV}-aks-dns"
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks-uami.id]
  }

  default_node_pool {
    name    = "default"
    vm_size = "Standard_DS2_v2"
    os_sku  = "Ubuntu"

    auto_scaling_enabled = true
    min_count            = 2
    max_count            = 10

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
    azurerm_user_assigned_identity.aks-uami
  ]
}
