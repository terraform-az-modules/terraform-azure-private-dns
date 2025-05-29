provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azure"
  version     = "1.0.0"
  name        = "app"
  environment = "dev"
  location    = "eastus"
  label_order = ["name", "environment", "location"]
}

##-----------------------------------------------------------------------------
## Vnet module call
##-----------------------------------------------------------------------------
module "vnet" {
  depends_on          = [module.resource_group]
  source              = "clouddrove/vnet/azure"
  version             = "1.0.4"
  name                = "dns"
  environment         = "testing"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

##-----------------------------------------------------------------------------
## Private DNS Zone module call
##-----------------------------------------------------------------------------

module "private_dns" {
  depends_on = [module.resource_group, module.vnet]
  source     = "../.."

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

  #Tags
  location    = module.resource_group.resource_group_location
  name        = "dns"
  environment = "testing"
}

