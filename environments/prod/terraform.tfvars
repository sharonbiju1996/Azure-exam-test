environment  = "prod"
location     = "eastus"
project_name = "pella"

address_space = ["10.20.0.0/16"]

subnets = {
  vm = {
    address_prefixes = ["10.20.1.0/24"]
    nsg_name         = "nsg-pella-prod-eastus-vm"
  }

  app = {
    address_prefixes = ["10.20.2.0/24"]
  }

  AzureBastionSubnet = {
    address_prefixes = ["10.20.3.0/26"]
  }
}

vm_name                = "vm-pella-prod-eastus"
vm_size                = "Standard_D2s_v3"
admin_username         = "azureuser"
network_interface_name = "nic-pella-prod-eastus-vm"

bastion_name           = "bas-pella-prod-eastus"
bastion_public_ip_name = "pip-pella-prod-eastus-bastion"

tags = {
  cost_center = "production"
}
