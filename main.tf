resource "azurerm_resource_group" "vwan_rg" {
  location = var.vwan_location
  name     = var.vwan_rg_name
}

resource "azurerm_virtual_wan" "vwan" {
  name                = var.vwan_name
  resource_group_name = var.vwan_rg_name
  location            = var.vwan_location
}

module "vwan_hubs" {
  source                   = "./VWAN-hubs"
  vwan_id                  = azurerm_virtual_wan.vwan.id
  vwan_location            = var.vwan_location
  vwan_name                = var.vwan_name
  vwan_rg_name             = var.vwan_rg_name
  vhub_east_location       = var.vhub_east_location
  vhub_east_address_prefix = var.vhub_east_address_prefix
  vhub_west_location       = var.vhub_west_location
  vhub_west_address_prefix = var.vhub_west_address_prefix
  ec1_vnet_id              = module.east_coast_1.ec1_vnet_id
  ec2_vnet_id              = module.east_coast_2.ec2_vnet_id
  wc1_vnet_id              = module.west_coast_1.wc1_vnet_id
  wc2_vnet_id              = module.west_coast_2.wc2_vnet_id
  depends_on               = [azurerm_resource_group.vwan_rg]
}

module "east_coast_1" {
  source                 = "./east-coast-1"
  ec1_location           = var.ec1_location
  ec1_rg_name            = var.ec1_rg_name
  ec1_vnet_address_space = var.ec1_vnet_address_space
  ec1_subnet_prefixes    = var.ec1_subnet_prefixes
  admin_password         = var.admin_password
}

module "east_coast_2" {
  source                 = "./east-coast-2"
  ec2_location           = var.ec2_location
  ec2_rg_name            = var.ec2_rg_name
  ec2_vnet_address_space = var.ec2_vnet_address_space
  ec2_subnet_prefixes    = var.ec2_subnet_prefixes
  admin_password         = var.admin_password
}

module "west_coast_1" {
  source                 = "./west-coast-1"
  wc1_location           = var.wc1_location
  wc1_rg_name            = var.wc1_rg_name
  wc1_vnet_address_space = var.wc1_vnet_address_space
  wc1_subnet_prefixes    = var.wc1_subnet_prefixes
  admin_password         = var.admin_password
}

module "west_coast_2" {
  source                 = "./west-coast-2"
  wc2_location           = var.wc2_location
  wc2_rg_name            = var.wc2_rg_name
  wc2_vnet_address_space = var.wc2_vnet_address_space
  wc2_subnet_prefixes    = var.wc2_subnet_prefixes
  admin_password         = var.admin_password
}