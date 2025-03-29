terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.24.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.17.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.2.0"
    }
  }
  #  backend "azurerm" {
  #    use_azuread_auth = true
  #    container_name   = "tfstate"
  #    key              = "terraform.tfstate"
  #  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  use_oidc                        = true

  client_id       = var.AZURE_CLIENT_ID
  tenant_id       = var.AZURE_TENANT_ID
  subscription_id = var.AZURE_SUBSCRIPTION_ID

  features {}
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
    client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  }
}

provider "azuread" {}
