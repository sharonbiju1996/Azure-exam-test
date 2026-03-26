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
}

admin_username       = "azureuser"

tags = {
  cost_center = "production"
}
