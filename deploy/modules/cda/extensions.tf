resource "azurerm_virtual_machine_extension" "vminstallscript" {
  name                 = "vm-install-script"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  settings             = <<SETTINGS
    {
     "fileUris": [
                "https://${var.project}${random_string.sastring.result}sa.blob.core.windows.net/scripts/nginx.sh"
                ]
    }
SETTINGS
  protected_settings   = <<PROTECTED_SETTINGS
    {
            "commandToExecute": "./nginx.sh",
            "storageAccountName": "${azurerm_storage_account.storageacct.name}",
            "storageAccountKey": "${azurerm_storage_account.storageacct.primary_access_key}"
   }
  PROTECTED_SETTINGS
}

#

resource "azurerm_virtual_machine_extension" "mma_extension" {
  name                 = "OmsAgentForLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "OmsAgentForLinux"
  type_handler_version = "1.14"
  settings             = jsonencode(local.mma_settings)
  protected_settings   = jsonencode(local.mma_protected_settings)

}

locals {
  mma_settings = {
    workspaceId = azurerm_log_analytics_workspace.law.workspace_id
    "skipDockerProviderInstall" : true
  }
  mma_protected_settings = {
    workspaceKey = azurerm_log_analytics_workspace.law.primary_shared_key
  }
}

##"script": "${base64encode(file(azurerm_storage_blob.nginx_script.name))}"
