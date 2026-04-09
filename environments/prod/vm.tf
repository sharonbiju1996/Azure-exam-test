resource "azurerm_public_ip" "bastion" {
  name                = var.bastion_public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = var.bastion_public_ip_allocation_method
  sku                 = var.bastion_public_ip_sku
  tags                = local.common_tags
}

resource "azurerm_bastion_host" "this" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = var.bastion_sku
  tags                = local.common_tags

  ip_configuration {
    name                 = var.bastion_ip_configuration_name
    subnet_id            = module.vnet.subnet_ids[var.bastion_subnet_key]
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
