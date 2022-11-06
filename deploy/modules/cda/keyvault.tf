resource "azurerm_key_vault" "keyvault" {
  location                    = azurerm_resource_group.resourcegroup.location
  name                        = "${var.project}-kv"
  resource_group_name         = azurerm_resource_group.resourcegroup.name
  sku_name                    = "standard"
  tenant_id                   = data.azurerm_subscription.sub.tenant_id
  enabled_for_disk_encryption = true
}



resource "random_password" "vmpassword" {
  length = 12
}

resource "azurerm_key_vault_secret" "vmpassword" {
  key_vault_id = azurerm_key_vault.keyvault.id
  name         = "vmpassword"
  value        = random_password.vmpassword.result
  depends_on = [
  azurerm_key_vault_access_policy.vmaccespol]
}



resource "azurerm_key_vault_access_policy" "vmaccespol" {
  key_vault_id = azurerm_key_vault.keyvault.id
  object_id    = data.azuread_client_config.current.object_id
  tenant_id    = data.azuread_client_config.current.tenant_id
  secret_permissions = [
    "Get",
    "List",
    "Backup", "Delete", "Get", "Purge", "Recover", "Restore", "Set"
  ]
  key_permissions =  [ "Get", "List","Create","Update","Purge","Delete"]
}

resource "azurerm_key_vault_key" "diskkey" {
  name         = "diskencrypt"
  key_vault_id = azurerm_key_vault.keyvault.id
  key_type     = "RSA"
  key_size     = 2048
  depends_on = [
    azurerm_key_vault_access_policy.vmaccespol
  ]

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}