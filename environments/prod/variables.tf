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

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
}

variable "admin_username" {
  type = string
}

variable "admin_ssh_public_key" {
  type      = string
  sensitive = true
}

variable "disable_password_authentication" {
  type    = bool
  default = true
}

variable "network_interface_name" {
  type = string
}

variable "nic_ip_configuration_name" {
  type    = string
  default = "internal"
}

variable "vm_subnet_key" {
  description = "Subnet key for VM"
  type        = string
  default     = "vm"
}

variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "vm_image_publisher" {
  type    = string
  default = "Canonical"
}

variable "vm_image_offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "vm_image_sku" {
  type    = string
  default = "22_04-lts"
}

variable "vm_image_version" {
  type    = string
  default = "latest"
}

variable "bastion_name" {
  type = string
}

variable "bastion_public_ip_name" {
  type = string
}

variable "bastion_public_ip_allocation_method" {
  type    = string
  default = "Static"
}

variable "bastion_public_ip_sku" {
  type    = string
  default = "Standard"
}

variable "bastion_sku" {
  type    = string
  default = "Basic"
}

variable "bastion_ip_configuration_name" {
  type    = string
  default = "bastion-ip-config"
}

variable "bastion_subnet_key" {
  type    = string
  default = "AzureBastionSubnet"
}

variable "tags" {
  type    = map(string)
  default = {}
}
