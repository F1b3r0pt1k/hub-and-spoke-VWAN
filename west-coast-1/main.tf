resource "azurerm_resource_group" "wc1_rg" {
  name     = var.wc1_rg_name
  location = var.wc1_location
}

resource "azurerm_virtual_network" "wc1_vnet" {
  name                = "${var.wc1_rg_name}-vnet"
  address_space       = var.wc1_vnet_address_space
  location            = var.wc1_location
  resource_group_name = var.wc1_rg_name
}

resource "azurerm_subnet" "wc1_subnet" {
  name                 = "internal"
  resource_group_name  = var.wc1_rg_name
  virtual_network_name = azurerm_virtual_network.wc1_vnet.name
  address_prefixes     = var.wc1_subnet_prefixes
}

resource "azurerm_network_interface" "wc1_vm_nic" {
  name                = "${var.wc1_rg_name}-vm-nic"
  location            = var.wc1_location
  resource_group_name = var.wc1_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.wc1_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "wc1_vm" {
  name                            = "${var.wc1_rg_name}-vm"
  resource_group_name             = var.wc1_rg_name
  location                        = var.wc1_location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.wc1_vm_nic.id,
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