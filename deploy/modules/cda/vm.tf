resource "azurerm_network_interface" "vmnic" {
  location            = azurerm_resource_group.resourcegroup.location
  name                = "${var.project}-vm-nic"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name                          = "vm-nic"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vmsubnet.id
    public_ip_address_id          = azurerm_public_ip.vmpip.id
  }
}

resource "azurerm_network_interface_security_group_association" "vmnsg" {
  network_interface_id      = azurerm_network_interface.vmnic.id
  network_security_group_id = azurerm_network_security_group.vmnsg.id
}


resource "azurerm_linux_virtual_machine" "vm" {
  admin_username                  = var.vm.admin_username
  admin_password                  = azurerm_key_vault_secret.vmpassword.value
  disable_password_authentication = false
  #zone = var.vm.zone
  location              = azurerm_resource_group.resourcegroup.location
  tags                  = var.tags
  name                  = "${var.project}-webserver-${var.vm.zone}"
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  resource_group_name   = azurerm_resource_group.resourcegroup.name
  size                  = var.vm.size
  computer_name         = "${var.project}-webserver-${var.vm.zone}"

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storageacct.primary_blob_endpoint
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.project}-webserver-osdisk-amd"
  }
  source_image_reference {
    publisher = var.vm.source_image_reference.publisher
    offer     = var.vm.source_image_reference.offer
    sku       = var.vm.source_image_reference.sku
    version   = var.vm.source_image_reference.version
  }
}





