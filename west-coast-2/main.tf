resource "azurerm_resource_group" "wc2_rg" {
  name     = var.wc2_rg_name
  location = var.wc2_location
}

resource "azurerm_virtual_network" "wc2_vnet" {
  name                = "${var.wc2_rg_name}-vnet"
  address_space       = var.wc2_vnet_address_space
  location            = var.wc2_location
  resource_group_name = var.wc2_rg_name
}

resource "azurerm_subnet" "wc2_subnet" {
  name                 = "internal"
  resource_group_name  = var.wc2_rg_name
  virtual_network_name = azurerm_virtual_network.wc2_vnet.name
  address_prefixes     = var.wc2_subnet_prefixes
}

resource "azurerm_network_interface" "wc2_vm_nic" {
  name                = "${var.wc2_rg_name}-vm-nic"
  location            = var.wc2_location
  resource_group_name = var.wc2_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.wc2_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "wc2_vm" {
  name                            = "${var.wc2_rg_name}-vm"
  resource_group_name             = var.wc2_rg_name
  location                        = var.wc2_location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.wc2_vm_nic.id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_network_security_group" "wc2_nsg" {
  name                = "wc2-nsg"
  location            = var.wc2_location
  resource_group_name = var.wc2_rg_name

  security_rule {
    name                       = "AllowPing"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "wc2_nsg_association" {
  subnet_id                 = azurerm_subnet.wc2_subnet.id
  network_security_group_id = azurerm_network_security_group.wc2_nsg.id
}