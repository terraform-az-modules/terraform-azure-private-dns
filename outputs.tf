##-----------------------------------------------------------------------------
## Output variables for referencing created DNS zones and links
##-----------------------------------------------------------------------------

output "private_dns_zone_ids" {
  description = "Private DNS Zone IDs for each resource type"
  value = {
    for resource_type, zone in azurerm_private_dns_zone.this : resource_type => zone.id
  }
}

output "private_dns_zone_names" {
  description = "Private DNS Zone names for each resource type"
  value       = local.dns_zone_map
}