variable "resource_group_name" {
  type        = string
  description = "Resource group name where the VNet will be created."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name."
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the VNet."
}

variable "subnets" {
  description = "Map of subnets to create."
  type = map(object({
    address_prefixes                              = list(string)
    service_endpoints                             = optional(list(string), [])
    private_endpoint_network_policies             = optional(string, "Enabled")
    private_link_service_network_policies_enabled = optional(bool, true)
    nsg_name                                      = optional(string)
  }))
}

variable "create_network_security_groups" {
  type        = bool
  description = "Create NSGs for subnets that define nsg_name."
  default     = true
}

variable "nsg_rules" {
  description = "Map of NSG names to rule definitions."
  type = map(list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  })))
  default = {}
}

variable "ddos_protection_plan_id" {
  type        = string
  description = "Optional DDoS protection plan ID."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
  default     = {}
}

variable "required_tags" {
  type        = set(string)
  description = "Tags that must exist."
  default     = ["environment", "region", "owner", "managed_by"]
}