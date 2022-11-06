resource "azurerm_resource_group" "resourcegroup" {
  location = var.location
  name     = "${var.project}-rg"
  tags     = var.tags
}