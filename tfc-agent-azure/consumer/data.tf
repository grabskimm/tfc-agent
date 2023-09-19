data "azurerm_resource_group" "main" {
  name     = "${var.prefix}-w3-net-rg"
  #location = var.location
}

data "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-w3-vnet"
  #address_space       = ["10.0.0.0/16"]
  #location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_subnet" "internal" {
  name                 = "${var.prefix}-snet-tools"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.main.name
  #address_prefixes     = ["10.0.16.0/20"]
}
