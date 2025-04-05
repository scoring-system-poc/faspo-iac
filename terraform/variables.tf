variable "AZURE_CLIENT_ID" {
  type = string
}


variable "AZURE_TENANT_ID" {
  type = string
}


variable "AZURE_SUBSCRIPTION_ID" {
  type = string
}


variable "AZURE_LOCATION" {
  type    = string
  default = "Germany West Central"

  validation {
    condition     = contains(["Germany West Central"], var.AZURE_LOCATION)
    error_message = "Invalid location"
  }
}


variable "PROJECT_NAME" {
  type    = string
  default = "scoring-system-poc"
}


variable "APP_NAME" {
  type    = string
  default = "faspo"

  validation {
    condition     = contains(["faspo"], var.APP_NAME)
    error_message = "Invalid app name"
  }
}


variable "ENV" {
  type    = string
  default = "poc"

  validation {
    condition     = contains(["poc", "dev", "uat", "prod"], var.ENV)
    error_message = "Invalid environment"
  }
}


variable "ARGOCD_DEPLOY_KEY" {
  type        = string
  sensitive   = true
  description = "SSH private key for ArgoCD to access the Git repository with APPS configuration."
}
