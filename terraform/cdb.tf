resource "azurerm_cosmosdb_account" "cdb" {
  name = "${var.APP_NAME}-${var.ENV}-cdb"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  location            = data.azurerm_resource_group.data-rg.location

  offer_type                    = "Standard"
  kind                          = "GlobalDocumentDB"
  public_network_access_enabled = false

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level = "Eventual"
  }

  geo_location {
    location          = data.azurerm_resource_group.data-rg.location
    failover_priority = 0
  }

  backup {
    type = "Continuous"
    tier = "Continuous7Days"
  }
}


resource "azurerm_cosmosdb_sql_database" "cdb" {
  name = "${var.APP_NAME}-${var.ENV}-cdb"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name

  depends_on = [
    azurerm_cosmosdb_account.cdb
  ]
}

