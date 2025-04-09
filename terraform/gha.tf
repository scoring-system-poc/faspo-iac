resource "azuread_application" "online-data-service-gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-online-data-service-gha"
  prevent_duplicate_names = true
}


resource "azuread_application" "batch-data-service-gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-batch-data-service-gha"
  prevent_duplicate_names = true
}


resource "azuread_application" "export-service-gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-export-service-gha"
  prevent_duplicate_names = true
}


resource "azuread_application" "store-service-gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-store-service-gha"
  prevent_duplicate_names = true
}


resource "azuread_service_principal" "online-data-service-gha-sp" {
  client_id  = azuread_application.online-data-service-gha-app.client_id
  depends_on = [azuread_application.online-data-service-gha-app]
}


resource "azuread_service_principal" "batch-data-service-gha-sp" {
  client_id  = azuread_application.batch-data-service-gha-app.client_id
  depends_on = [azuread_application.batch-data-service-gha-app]
}


resource "azuread_service_principal" "export-service-gha-sp" {
  client_id  = azuread_application.export-service-gha-app.client_id
  depends_on = [azuread_application.export-service-gha-app]
}


resource "azuread_service_principal" "store-service-gha-sp" {
  client_id  = azuread_application.store-service-gha-app.client_id
  depends_on = [azuread_application.store-service-gha-app]
}

