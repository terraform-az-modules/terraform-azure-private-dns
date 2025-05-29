##----------------------------------------------------------------------------
## Outputs
##----------------------------------------------------------------------------
output "dns_zone_id_keyvault" {
  value = module.private_dns.private_dns_zone_ids.key_vault
}

output "dns_zone_name" {
  value = module.private_dns.private_dns_zone_names.key_vault
}