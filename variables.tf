# Root Module Variables
variable "vwan_rg_name" {
  type        = string
  description = "Name of the resource group for the Virtual WAN"
}

variable "vwan_location" {
  type        = string
  description = "Location of the Virtual WAN"
}

variable "vwan_name" {
  type        = string
  description = "Name of the Virtual WAN"
}

variable "base_name" {
  type        = string
  description = "Base name for all resources"
}

# Hub Module Variables
variable "vhub_east_location" {
  type        = string
  description = "Location of the East Coast Virtual Hub"
}

variable "vhub_east_address_prefix" {
  type        = string
  description = "Address prefix for the East Coast Virtual Hub"
}

variable "vhub_west_location" {
  type        = string
  description = "Location of the West Coast Virtual Hub"
}

variable "vhub_west_address_prefix" {
  type        = string
  description = "Address prefix for the East Coast Virtual Hub"
}
# East Coast 1 Variables
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

# East Coast 2 Variables
variable "ec2_location" {
  type        = string
  description = "Location of the East Coast 1 resources"
}

variable "ec2_rg_name" {
  type        = string
  description = "Name of the resource group for the East Coast 1 resources"
}

variable "ec2_vnet_address_space" {
  type        = list(string)
  description = "Address space for the East Coast 1 VNet"
}

variable "ec2_subnet_prefixes" {
  type        = list(string)
  description = "Prefixes for the East Coast 1 subnet"
}

# West Coast 1 Variables
variable "wc1_location" {
  type        = string
  description = "Location of the East Coast 1 resources"
}

variable "wc1_rg_name" {
  type        = string
  description = "Name of the resource group for the East Coast 1 resources"
}

variable "wc1_vnet_address_space" {
  type        = list(string)
  description = "Address space for the East Coast 1 VNet"
}

variable "wc1_subnet_prefixes" {
  type        = list(string)
  description = "Prefixes for the East Coast 1 subnet"
}

# West Coast 2 Variables
variable "wc2_location" {
  type        = string
  description = "Location of the East Coast 1 resources"
}

variable "wc2_rg_name" {
  type        = string
  description = "Name of the resource group for the East Coast 1 resources"
}

variable "wc2_vnet_address_space" {
  type        = list(string)
  description = "Address space for the East Coast 1 VNet"
}

variable "wc2_subnet_prefixes" {
  type        = list(string)
  description = "Prefixes for the East Coast 1 subnet"
}

