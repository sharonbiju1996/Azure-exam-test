resource "azurerm_storage_account" "this" {
  name                            = lower(replace("st${var.project_name}${var.environment}${substr(var.location, 0, 6)}001", "-", ""))
  resource_group_name             = azurerm_resource_group.this.name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = local.common_tags
}

resource "azurerm_storage_container" "artifacts" {
  name                  = "artifacts"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}