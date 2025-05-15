provider "azurerm" {
  features {}
  subscription_id = "1ac2caa4-336e-4daa-b8f1-0fbabe2d4b11"
}

locals {
  name        = "dns"
  environment = "testing"
  label_order = ["name", "environment", ]
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "clouddrove/resource-group/azure"
  version     = "1.0.2"
  name        = local.name
  environment = local.environment
  label_order = local.label_order
  location    = "East US"
}

##-----------------------------------------------------------------------------
## Vnet module call
##-----------------------------------------------------------------------------
module "vnet" {
  depends_on          = [module.resource_group]
  source              = "clouddrove/vnet/azure"
  version             = "1.0.4"
  name                = local.name
  environment         = local.environment
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

##-----------------------------------------------------------------------------
## Private DNS Zone module call
##-----------------------------------------------------------------------------

module "private_dns" {
  depends_on = [module.resource_group, module.vnet]
  source     = "../"

  resource_group_name = module.resource_group.resource_group_name
  private_dns_config = [
    {
      resource_type = "key_vault"
      vnet_ids      = [module.vnet.vnet_id, module.vnet.vnet_id]
    },
    {
      resource_type = "storage_account"
      vnet_ids      = [module.vnet.vnet_id]
    }
    # {
    #   resource_type = "custom_dns"
    #   vnet_ids      = ["/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet-custom"]
    #   zone_name     = "my.custom.zone.internal"
    # }
  ]
}

