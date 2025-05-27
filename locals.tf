##----------------------------------------------------------------------------
## Locals
##----------------------------------------------------------------------------
locals {
  dns_zone_map = {
    key_vault                 = "privatelink.vaultcore.azure.net"
    storage_account           = "privatelink.blob.core.windows.net"
    container_registry        = "privatelink.azurecr.io"
    sql_server                = "privatelink.database.windows.net"
    postgresql_server         = "privatelink.postgres.database.azure.com"
    mysql_server              = "privatelink.mysql.database.azure.com"
    cosmos_db                 = "privatelink.documents.azure.com"
    synapse_analytics         = "privatelink.sql.azuresynapse.net"
    event_hub                 = "privatelink.servicebus.windows.net"
    service_bus               = "privatelink.servicebus.windows.net"
    azure_ai_services         = "privatelink.cognitiveservices.azure.com"
    azure_file                = "privatelink.file.core.windows.net"
    azure_data_lake           = "privatelink.dfs.core.windows.net"
    azure_monitor             = "privatelink.monitor.azure.com"
    azure_backup              = "privatelink.backup.windowsazure.com"
    azure_site_recovery       = "privatelink.siterecovery.windowsazure.com"
    azure_automation          = "privatelink.agentsvc.azure-automation.net"
    azure_machine_learning    = "privatelink.api.azureml.ms"
    azure_kubernetes          = "privatelink.{region}.azmk8s.io"
    azure_redis               = "privatelink.redis.cache.windows.net"
    azure_search              = "privatelink.search.windows.net"
    azure_sql_sync            = "privatelink.database.windows.net"
    azure_data_factory        = "privatelink.datafactory.azure.net"
    azure_data_factory_portal = "privatelink.adf.azure.com"
    azure_event_grid          = "privatelink.eventgrid.azure.net"
    azure_relay               = "privatelink.servicebus.windows.net"
    azure_app_config          = "privatelink.azconfig.io"
    azure_purview             = "privatelink.purview.azure.com"
    azure_purview_studio      = "privatelink.purviewstudio.azure.com"
    azure_batch               = "privatelink.{region}.batch.azure.com"
    azure_web_apps            = "privatelink.azurewebsites.net"
    azure_function_apps       = "privatelink.azurewebsites.net"
    azure_api_management      = "privatelink.azure-api.net"
    azure_signalr             = "privatelink.service.signalr.net"
    azure_iot_hub             = "privatelink.azure-devices.net"
    azure_digital_twins       = "privatelink.digitaltwins.azure.net"
    azure_video_indexer       = "privatelink.api.videoindexer.ai"
  }

  enabled_configs = var.enable ? var.private_dns_config : []

  zone_configs = { for cfg in var.private_dns_config : cfg.resource_type => cfg if contains(keys(local.dns_zone_map), cfg.resource_type) }

  test = {
    for cfg in var.private_dns_config :
    cfg.resource_type => cfg.vnet_ids
    if contains(keys(local.dns_zone_map), cfg.resource_type)
  }

}