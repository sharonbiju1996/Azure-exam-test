environment  = "dev"
location     = "eastus"
project_name = "pella"
address_space = ["10.10.0.0/16"]
subnets = {
  vm = {
    address_prefixes = ["10.10.1.0/24"]
    nsg_name         = "nsg-pella-dev-eastus-vm"
  }
  app = {
    address_prefixes = ["10.10.2.0/24"]
  }
}
vm_size = "Standard_B1s"
admin_username       = "azureuser"
vm_name                = "vm-pella-dev-eastus"
public_ip_name         = "pip-pella-dev-eastus-vm"
network_interface_name = "nic-pella-dev-eastus-vm"
tags = {
  cost_center = "devops"
}
