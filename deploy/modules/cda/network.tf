resource "azurerm_virtual_network" "vnet" {
  address_space       = [var.network.vnet_address]
  location            = azurerm_resource_group.resourcegroup.location
  name                = "${var.project}-vnet"
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

resource "azurerm_subnet" "vmsubnet" {
  address_prefixes     = [var.network.subnet_address]
  name                 = "${var.project}-vm-subnet"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "vmnsg" {
  location            = azurerm_resource_group.resourcegroup.location
  name                = "${var.project}-vm-nsg"
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

resource "azurerm_public_ip" "vmpip" {
  allocation_method   = "Dynamic"
  location            = azurerm_resource_group.resourcegroup.location
  name                = "${var.project}-vm-pip"
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

resource "azurerm_network_security_rule" "vminbound" {
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "AL-IN-HTTPS"
  network_security_group_name = azurerm_network_security_group.vmnsg.name
  priority                    = 101
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.resourcegroup.name
  destination_address_prefix  = var.network.subnet_address
  destination_port_range      = "443"
  source_address_prefix       = var.network.source_ip
  source_port_range           = "*"
}



resource "azurerm_network_security_rule" "inbound-ssh" {
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "AL-IN-SSH"
  network_security_group_name = azurerm_network_security_group.vmnsg.name
  priority                    = 102
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.resourcegroup.name
  destination_address_prefix  = var.network.subnet_address
  destination_port_range      = "22"
  source_address_prefix       = var.network.source_ip
  source_port_range           = "*"
}
