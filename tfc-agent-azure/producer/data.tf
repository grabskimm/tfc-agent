data "azurerm_resource_group" "main" {
  name     = "${var.prefix}-net-rg"
}

data "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_subnet" "internal" {
  name                 = "${var.prefix}-snet-tfc-agent"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.main.name
}
