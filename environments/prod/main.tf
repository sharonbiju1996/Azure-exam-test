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
    "nsg-pella-prod-eastus-vm" = [
      {
        name                       = "allow-ssh-internal"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "10.0.0.0/8"
        destination_address_prefix = "*"
      }
    ]
  }

  tags = local.common_tags
}

