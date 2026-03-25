output "vnet_id" {
  value       = azurerm_virtual_network.this.id
  description = "Virtual network ID."
}

output "vnet_name" {
  value       = azurerm_virtual_network.this.name
  description = "Virtual network name."
}

output "subnet_ids" {
  value       = { for k, v in azurerm_subnet.this : k => v.id }
  description = "Map of subnet IDs."
}

output "subnet_names" {
  value       = keys(azurerm_subnet.this)
  description = "Subnet names."
}

output "nsg_ids" {
  value       = { for k, v in azurerm_network_security_group.this : k => v.id }
  description = "Map of NSG IDs."
}