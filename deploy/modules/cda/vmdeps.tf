resource "azurerm_log_analytics_workspace" "law" {
  location            = azurerm_resource_group.resourcegroup.location
  name                = azurerm_resource_group.resourcegroup.name
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

