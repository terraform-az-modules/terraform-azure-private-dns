##-----------------------------------------------------------------------------
## Tagging Module – Applies standard tags to all resources
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azure"
  version         = "1.0.0"
  name            = var.name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##----------------------------------------------------------------------------
## Resource – Private DNS Zones for supported Azure PaaS services
##----------------------------------------------------------------------------
resource "azurerm_private_dns_zone" "this" {
  for_each = var.enable ? local.zone_configs : {}

  name                = local.dns_zone_map[each.key]
  resource_group_name = var.resource_group_name
  tags                = module.labels.tags
}

## ----------------------------------------------------------------------------
## Resource – VNet Links to Private DNS Zones
##----------------------------------------------------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.enable ? {
    for pair in flatten([
      for resource_type, vnet_ids in local.test : [
        for idx, vnet_id in vnet_ids : {
          key           = "${resource_type}-${idx}"
          resource_type = resource_type
          vnet_id       = vnet_id
        }
      ]
    ]) : pair.key => pair
  } : {}

  name                  = "${replace(basename(each.value.vnet_id), ".", "-")}-${each.value.resource_type}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = local.dns_zone_map[each.value.resource_type]
  virtual_network_id    = each.value.vnet_id
  registration_enabled  = false
}