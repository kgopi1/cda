terraform {
  backend "azurerm" {
    storage_account_name = ""
    subscription_id      = ""
    resource_group_name  = ""
    container_name       = "cda"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      version = "3.30.0"
    }
  }
  required_version = ">= 1.3.0"
}


