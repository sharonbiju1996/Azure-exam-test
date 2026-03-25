run "vnet_basic" {
  command = plan

  variables {
    resource_group_name = "rg-test-eastus"
    location            = "eastus"
    vnet_name           = "vnet-test-eastus"
    address_space       = ["10.99.0.0/16"]
    tags = {
      environment = "test"
      region      = "eastus"
      owner       = "platform-team"
      managed_by  = "terraform"
    }
    subnets = {
      app = {
        address_prefixes = ["10.99.1.0/24"]
      }
    }
  }

  assert {
    condition     = output.vnet_name == "vnet-test-eastus"
    error_message = "Unexpected VNet name"
  }
}