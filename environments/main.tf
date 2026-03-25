terraform {
  required_version = ">= 1.6.0"

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
  name_prefix = "${var.project_name}-${var.environment}-${var.location}"

  common_tags = merge(var.tags, {
    environment = var.environment
    region      = var.location
    managed_by  = "terraform"
    owner       = "platform-team"
    project     = var.project_name
  })
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.common_tags
}

module "vnet" {
  source = "../../modules/vnet"

  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  vnet_name           = "vnet-${local.name_prefix}"
  address_space       = var.address_space
  subnets             = var.subnets

  # stricter rules in prod
  nsg_rules = {
    "nsg-${local.name_prefix}-vm" = [
      {
        name                       = "allow-ssh-from-bastion"
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