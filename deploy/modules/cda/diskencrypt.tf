## https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/azure-disk-enc-linux

# disk encryption will fail due to low vm spec.

resource "azurerm_virtual_machine_extension" "diskencrypt" {
  name                       = "AzureDiskEncryption"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryptionForLinux"
  type_handler_version       = "1.1"
  auto_upgrade_minor_version = true
  depends_on = [
    azurerm_linux_virtual_machine.vm,
    azurerm_key_vault_key.diskkey
  ]
  settings = <<SETTINGS
    {

        "EncryptionOperation": "EnableEncryption",
        "KeyEncryptionAlgorithm": "RSA-OAEP",
        "KeyVaultURL": "${azurerm_key_vault.keyvault.vault_uri}",
        "KeyVaultResourceId": "${azurerm_key_vault.keyvault.id}",
        "KeyEncryptionKeyURL": "${azurerm_key_vault_key.diskkey.id}",
        "KekVaultResourceId": "${azurerm_key_vault.keyvault.id}",
        "VolumeType": "All"
    }
SETTINGS
  tags     = var.tags
}