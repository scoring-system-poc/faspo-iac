resource "azurerm_cosmosdb_account" "cdb" {
  name = "${var.APP_NAME}-${var.ENV}-cdb"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  location            = data.azurerm_resource_group.data-rg.location

  offer_type                    = "Standard"
  kind                          = "GlobalDocumentDB"
  public_network_access_enabled = false

  # following is mostly only for testing on private account (to minimize cost)
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


resource "azurerm_cosmosdb_sql_container" "subject-container" {
  name = "subject"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  database_name       = azurerm_cosmosdb_sql_database.cdb.name

  partition_key_paths = ["/id"]

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_cosmosdb_sql_database.cdb
  ]
}


resource "azurerm_cosmosdb_sql_container" "document-container" {
  name = "document"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  database_name       = azurerm_cosmosdb_sql_database.cdb.name

  partition_key_paths = ["/subjectId"]
  default_ttl         = -1

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/_etag/?"
    }

    excluded_path {
      path = "/items/*"
    }
  }

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_cosmosdb_sql_database.cdb
  ]
}


resource "azurerm_cosmosdb_sql_container" "metadata-container" {
  name = "metadata"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  database_name       = azurerm_cosmosdb_sql_database.cdb.name

  partition_key_paths = ["/id"] # f"{doc_type}#{part}"

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_cosmosdb_sql_database.cdb
  ]
}


resource "azurerm_cosmosdb_sql_container" "metadata-container" {
  name = "metadata"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  database_name       = azurerm_cosmosdb_sql_database.cdb.name

  partition_key_paths = ["/id"] # f"{doc_type}#{part}"

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_cosmosdb_sql_database.cdb
  ]
}


resource "azurerm_cosmosdb_sql_container" "codetable-container" {
  name = "codetable"

  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  database_name       = azurerm_cosmosdb_sql_database.cdb.name

  partition_key_paths = ["/id"] # f"{doc_type}#{part}#{cell_row}#{cell_col}"

  depends_on = [
    azurerm_cosmosdb_account.cdb,
    azurerm_cosmosdb_sql_database.cdb
  ]
}


data "azurerm_cosmosdb_sql_role_definition" "cosmos-reader-role" {
  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  role_definition_id  = "00000000-0000-0000-0000-000000000001"

  depends_on = [
    azurerm_cosmosdb_account.cdb
  ]
}


data "azurerm_cosmosdb_sql_role_definition" "cosmos-contributor-role" {
  resource_group_name = data.azurerm_resource_group.data-rg.name
  account_name        = azurerm_cosmosdb_account.cdb.name
  role_definition_id  = "00000000-0000-0000-0000-000000000002"

  depends_on = [
    azurerm_cosmosdb_account.cdb
  ]
}

