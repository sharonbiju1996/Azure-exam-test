variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "project_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    address_prefixes                              = list(string)
    service_endpoints                             = optional(list(string), [])
    private_endpoint_network_policies             = optional(string, "Enabled")
    private_link_service_network_policies_enabled = optional(bool, true)
    nsg_name                                      = optional(string)
  }))
}

variable "admin_username" {
  type = string
}

variable "admin_ssh_public_key" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}