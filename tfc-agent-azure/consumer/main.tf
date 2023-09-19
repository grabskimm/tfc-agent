provider "azurerm" {

  client_id       = var.az_clientID
  client_secret   = var.az_secret
  tenant_id       = var.az_tenant

  features {}

  # These may also be provided as environment variables
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#argument-reference
  subscription_id = var.subscription_id
  use_msi         = true
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-tfc-agent-nic"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-tfc-agent-vm"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  size                            = "Standard_B1s"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false

  network_interface_ids = [ azurerm_network_interface.main.id ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
