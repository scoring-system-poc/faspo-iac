resource "azuread_application" "gha-app" {
  display_name            = "${var.APP_NAME}-${var.ENV}-gha-iac"
  prevent_duplicate_names = true
}
