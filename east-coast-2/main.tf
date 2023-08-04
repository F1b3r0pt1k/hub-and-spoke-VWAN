resource "azurerm_resource_group" "ec2_rg" {
  name     = var.ec2_rg_name
  location = var.ec2_location
}

resource "azurerm_virtual_network" "ec2_vnet" {
  name                = "${var.ec2_rg_name}-vnet"
  address_space       = var.ec2_vnet_address_space
  location            = var.ec2_location
  resource_group_name = var.ec2_rg_name
}

resource "azurerm_subnet" "ec2_subnet" {
  name                 = "internal"
  resource_group_name  = var.ec2_rg_name
  virtual_network_name = azurerm_virtual_network.ec2_vnet.name
  address_prefixes     = var.ec2_subnet_prefixes
}

resource "azurerm_network_interface" "ec2_vm_nic" {
  name                = "${var.ec2_rg_name}-vm-nic"
  location            = var.ec2_location
  resource_group_name = var.ec2_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ec2_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "ec2_vm" {
  name                            = "${var.ec2_rg_name}-vm"
  resource_group_name             = var.ec2_rg_name
  location                        = var.ec2_location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.ec2_vm_nic.id,
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