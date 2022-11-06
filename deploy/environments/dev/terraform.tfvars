project = "cda"

location = "westeurope"

vm = {
  admin_username = "cdaadmin"
  size           = "Standard_B2s"
  zone           = 1
  source_image_reference = {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

network = {
  vnet_address   = "10.0.1.0/24"
  subnet_address = "10.0.1.32/28"
  source_ip      = "82.33.88.114"
}


tags = {
  project     = "cda"
  environment = "dev"
}

