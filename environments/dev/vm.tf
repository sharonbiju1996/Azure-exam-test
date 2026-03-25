resource "azurerm_public_ip" "vm" {
  name                = "pip-${local.name_prefix}-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

resource "azurerm_network_interface" "vm" {
  name                = "nic-${local.name_prefix}-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.common_tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_ids["vm"]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${local.name_prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = "Standard_B1ms"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]
  disable_password_authentication = true
  tags                            = local.common_tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}