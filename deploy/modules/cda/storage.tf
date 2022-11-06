resource "random_string" "sastring" {
  length      = 5
  min_upper   = 0
  min_special = 0
  upper       = false
  special     = false
  numeric     = false

}


resource "azurerm_storage_account" "storageacct" {
  account_replication_type          = "LRS"
  account_tier                      = "Standard"
  location                          = azurerm_resource_group.resourcegroup.location
  name                              = "${var.project}${random_string.sastring.result}sa"
  resource_group_name               = azurerm_resource_group.resourcegroup.name
  enable_https_traffic_only         = true
  infrastructure_encryption_enabled = false # set to false to report in checkov scan
  blob_properties {
    versioning_enabled       = true
    last_access_time_enabled = false # set to false to report in checkov scan
  }
  queue_properties { # disabled the queue logging to report in checkov scan.
    #    logging {
    #      delete  = false
    #      read    = false
    #      version = ""
    #      write   = false
    #    }
  }
}



resource "azurerm_storage_container" "scripts" {
  name                 = "scripts"
  storage_account_name = azurerm_storage_account.storageacct.name
}


resource "azurerm_storage_blob" "nginx_script" {
  name                   = "nginx.sh"
  storage_account_name   = azurerm_storage_account.storageacct.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source_content         = file("../../scripts/nginx.sh")
}
