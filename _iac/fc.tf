resource "azuread_application_federated_identity_credential" "gha-app-fc" {
  display_name = "${var.APP_NAME}-${var.ENV}-gha-iac-fc"

  application_id = azuread_application.gha-app.id

  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:${var.PROJECT_NAME}/${var.APP_NAME}-iac:environment:env/${var.ENV}"
  audiences = ["api://AzureADTokenExchange"]

  depends_on = [
    azuread_application.gha-app
  ]
}

