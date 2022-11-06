data "azurerm_subscription" "sub" {
  subscription_id = ""
}

data "azuread_client_config" "current" {
}

data "azurerm_key_vault_key" "diskkey" {
  name                = "diskencrypt"
  key_vault_id        = azurerm_key_vault.keyvault.id
}

