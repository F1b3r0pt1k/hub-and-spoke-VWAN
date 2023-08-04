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

variable "vwan_id" {
}

### East Coast Hub

variable "vhub_east_location" {
  type        = string
  description = "Location of the East Coast Virtual Hub"
}

variable "vhub_east_address_prefix" {
  type        = string
  description = "Address prefix for the East Coast Virtual Hub"
}

variable "ec1_vnet_id" {
  type        = string
  description = "ID of east-coast-1 vnet"
}

variable "ec2_vnet_id" {
  type        = string
  description = "ID of east-coast-2 vnet"
}

### West Coast Hub

variable "vhub_west_location" {
  type        = string
  description = "Location of the West Coast Virtual Hub"
}

variable "vhub_west_address_prefix" {
  type        = string
  description = "Address prefix for the East Coast Virtual Hub"
}

variable "wc1_vnet_id" {
  type        = string
  description = "ID of west-coast-1 vnet"
}

variable "wc2_vnet_id" {
  type        = string
  description = "ID of west-coast-2 vnet"
}