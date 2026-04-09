resource "azurerm_public_ip" "vm" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  tags                = local.common_tags
}

resource "azurerm_network_interface" "vm" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.common_tags

  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = module.vnet.subnet_ids[var.vm_subnet_key]
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]
  disable_password_authentication = var.disable_password_authentication
  tags                            = local.common_tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }
}
