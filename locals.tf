locals {
  dns_zone_map = {
    key_vault          = "privatelink.vaultcore.azure.net"
    storage_account    = "privatelink.blob.core.windows.net"
    container_registry = "privatelink.azurecr.io"
    sql_server         = "privatelink.database.windows.net"
  }

  enabled_configs = var.enable ? var.private_dns_config : []

  zone_configs = { for cfg in var.private_dns_config : cfg.resource_type => cfg if contains(keys(local.dns_zone_map), cfg.resource_type) }

  test = {
    for cfg in var.private_dns_config :
    cfg.resource_type => cfg.vnet_ids
    if contains(keys(local.dns_zone_map), cfg.resource_type)
  }

}