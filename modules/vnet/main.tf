locals {
  nsg_names = distinct([
    for s in values(var.subnets) : s.nsg_name
    if try(s.nsg_name, null) != null
  ])
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_id != null ? [1] : []
    content {
      id     = var.ddos_protection_plan_id
      enable = true
    }
  }

  lifecycle {
    precondition {
      condition     = alltrue([for tag in var.required_tags : contains(keys(var.tags), tag)])
      error_message = "Missing one or more required tags."
    }
  }
}

resource "azurerm_network_security_group" "this" {
  for_each            = var.create_network_security_groups ? toset(local.nsg_names) : []
  name                = each.value
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "this" {
  for_each = {
    for item in flatten([
      for nsg_name, rules in var.nsg_rules : [
        for rule in rules : {
          key  = "${nsg_name}-${rule.name}"
          nsg  = nsg_name
          rule = rule
        }
      ]
    ]) : item.key => item
  }

  name                        = each.value.rule.name
  priority                    = each.value.rule.priority
  direction                   = each.value.rule.direction
  access                      = each.value.rule.access
  protocol                    = each.value.rule.protocol
  source_port_range           = each.value.rule.source_port_range
  destination_port_range      = each.value.rule.destination_port_range
  source_address_prefix       = each.value.rule.source_address_prefix
  destination_address_prefix  = each.value.rule.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = each.value.nsg
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints

  private_endpoint_network_policies             = each.value.private_endpoint_network_policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = {
    for subnet_name, subnet in var.subnets :
    subnet_name => subnet
    if try(subnet.nsg_name, null) != null && var.create_network_security_groups
  }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.value.nsg_name].id
}