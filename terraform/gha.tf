resource "azuread_application" "store-service-gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-store-service-gha"
  prevent_duplicate_names = true
}


resource "azuread_service_principal" "store-service-gha-sp" {
  client_id  = azuread_application.store-service-gha-app.client_id
  depends_on = [azuread_application.store-service-gha-app]
}

