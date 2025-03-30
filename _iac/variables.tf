variable "AZURE_TENANT_ID" {
  type        = string
  description = "The ID of tenant in which whole system is located"
}

variable "AZURE_SUBSCRIPTION_ID" {
  type        = string
  description = "The ID of subscription under which all resources are located"
}


variable "GHB_DATABASE_ID" {
  type        = string
  description = "The database ID of the organization/enterprise in GitHub"
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

  description = "Name of environment (e.g. poc, dev, uat, prod)"

  validation {
    condition     = contains(["poc", "dev", "uat", "prod"], var.ENV)
    error_message = "Invalid environment"
  }
}

