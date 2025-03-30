resource "azuread_application" "gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-gha-iac"
  prevent_duplicate_names = true
}


resource "azuread_service_principal" "gha-app-sp" {
  client_id = azuread_application.gha-app.client_id

  depends_on = [
    azuread_application.gha-app
  ]
}

