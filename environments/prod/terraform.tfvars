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
admin_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKpvmgQg06ZrorcB2Lb1R3DZbuvX0ro6sutRhXsvIk5 sharon@LAPTOP-TE8M6PSA"

tags = {
  cost_center = "production"
}