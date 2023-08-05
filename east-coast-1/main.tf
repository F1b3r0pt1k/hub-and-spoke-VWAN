resource "azurerm_resource_group" "ec1_rg" {
  name     = var.ec1_rg_name
  location = var.ec1_location
}

resource "azurerm_virtual_network" "ec1_vnet" {
  name                = "${var.ec1_rg_name}-vnet"
  address_space       = var.ec1_vnet_address_space
  location            = var.ec1_location
  resource_group_name = var.ec1_rg_name
}

resource "azurerm_subnet" "ec1_subnet" {
  name                 = "internal"
  resource_group_name  = var.ec1_rg_name
  virtual_network_name = azurerm_virtual_network.ec1_vnet.name
  address_prefixes     = var.ec1_subnet_prefixes
}

resource "azurerm_public_ip" "ec1_vm_pip" {
  allocation_method   = "Static"
  location            = var.ec1_location
  name                = "jumpbox-pip"
  resource_group_name = var.ec1_rg_name
}
resource "azurerm_network_interface" "ec1_vm_nic" {
  name                = "${var.ec1_rg_name}-vm-nic"
  location            = var.ec1_location
  resource_group_name = var.ec1_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ec1_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ec1_vm_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "ec1_vm" {
  name                            = "${var.ec1_rg_name}-vm"
  resource_group_name             = var.ec1_rg_name
  location                        = var.ec1_location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.ec1_vm_nic.id,
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

# Add NSG to subnet
resource "azurerm_network_security_group" "ec1_nsg" {
  name                = "ec1-nsg"
  location            = var.ec1_location
  resource_group_name = var.ec1_rg_name

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
    security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "ec1_nsg_association" {
  subnet_id                 = azurerm_subnet.ec1_subnet.id
  network_security_group_id = azurerm_network_security_group.ec1_nsg.id
}