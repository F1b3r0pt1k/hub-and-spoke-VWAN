### East Coast Hub
resource "azurerm_virtual_hub" "east_coast_hub" {
  name                = "east-coast-vhub"
  resource_group_name = var.vwan_rg_name
  location            = var.vwan_location
  virtual_wan_id      = var.vwan_id
  address_prefix      = var.vhub_east_address_prefix
}

resource "azurerm_virtual_hub_connection" "eastcoast1_to_hub" {
  name                      = "eastcoast1_to_hub"
  virtual_hub_id            = azurerm_virtual_hub.east_coast_hub.id
  remote_virtual_network_id = var.ec1_vnet_id
}

resource "azurerm_virtual_hub_connection" "eastcoast2_to_hub" {
  name                      = "eastcoast2_to_hub"
  virtual_hub_id            = azurerm_virtual_hub.east_coast_hub.id
  remote_virtual_network_id = var.ec2_vnet_id
}

### West Coast Hub

resource "azurerm_virtual_hub" "west_coast_hub" {
  name                = "west-coast-vhub"
  resource_group_name = var.vwan_rg_name
  location            = var.vhub_west_location
  virtual_wan_id      = var.vwan_id
  address_prefix      = var.vhub_west_address_prefix
}

resource "azurerm_virtual_hub_connection" "westcoast1_to_hub" {
  name                      = "westcoast1_to_hub"
  virtual_hub_id            = azurerm_virtual_hub.west_coast_hub.id
  remote_virtual_network_id = var.wc1_vnet_id
}

resource "azurerm_virtual_hub_connection" "westcoast2_to_hub" {
  name                      = "westcoast2_to_hub"
  virtual_hub_id            = azurerm_virtual_hub.west_coast_hub.id
  remote_virtual_network_id = var.wc2_vnet_id
}