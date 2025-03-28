terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.24.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.2.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.3.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.AZURE_SUBSCRIPTION_ID
  features {}
}

provider "azuread" {}

provider "azapi" {}
