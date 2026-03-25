terraform {
  required_version = ">= 1.6.0"

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}



module "vnet" {
  source = "../../modules/vnet"

  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  vnet_name           = "vnet-${local.name_prefix}"
  address_space       = var.address_space
  subnets             = var.subnets

  nsg_rules = {
    "nsg-${local.name_prefix}-vm" = [
      {
        name                       = "allow-ssh-from-home"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  tags = local.common_tags
}




