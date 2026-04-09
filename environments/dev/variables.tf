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

# ---------- VM VARIABLES ----------

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

# ---------- NETWORK ----------

variable "public_ip_name" {
  type = string
}

variable "network_interface_name" {
  type = string
}

variable "vm_subnet_key" {
  description = "Subnet key for VM"
  type        = string
  default     = "vm"
}

# ---------- DISK ----------

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

# ---------- IMAGE ----------

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

# ---------- TAGS ----------

variable "tags" {
  type    = map(string)
  default = {}
}
