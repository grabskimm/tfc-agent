provider "azurerm" {

  client_id       = var.az_clientID
  client_secret   = var.az_secret
  tenant_id       = var.az_tenant

  features {}
  
  subscription_id = var.subscription_id
  use_msi         = true
}

resource "azurerm_container_group" "tfc-agent" {
  name                = "tfc-agent"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  os_type             = "Linux"
  restart_policy      = "Always"
  ip_address_type     = "Private"
  subnet_ids          = [ data.azurerm_subnet.internal.id ]


  container {
    name   = "tfc-agent"
    image  = "hashicorp/tfc-agent:latest"
    cpu    = "1.0"
    memory = "2.0"

    # this field seems to be mandatory (error happens if not there). See https://github.com/terraform-providers/terraform-provider-azurerm/issues/1697#issuecomment-608669422
    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      TFC_AGENT_SINGLE = "True"
    }

    secure_environment_variables = {
      TFC_AGENT_TOKEN = var.tfc_agent_token
    }
  }

  identity {
    type = "SystemAssigned"
  }
}