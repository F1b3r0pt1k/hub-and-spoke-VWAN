variable "ec1_location" {
  type        = string
  description = "Location of the East Coast 1 resources"
}

variable "ec1_rg_name" {
  type        = string
  description = "Name of the resource group for the East Coast 1 resources"
}

variable "ec1_vnet_address_space" {
  type        = list(string)
  description = "Address space for the East Coast 1 VNet"
}

variable "ec1_subnet_prefixes" {
  type        = list(string)
  description = "Prefixes for the East Coast 1 subnet"
}

variable "admin_password" {
  type        = string
  description = "Password for the VM"
}
