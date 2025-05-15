# terraform-azurerm-paas-private-dns

## 🚧 Azure Private DNS for PaaS Terraform Module (Beta)

This Terraform module provisions **Azure Private DNS Zones** for commonly used **PaaS services** (like Azure Key Vault, Container Registry, MySQL Flexible Server, etc.) and links them to the specified Virtual Networks.

> ⚠️ **Beta Notice**  
> This module is in **beta** — use with caution and validate before production deployments. Future versions may introduce changes to variable structures or resource handling.

---

## 📦 Features

- Provision managed Private DNS Zones for Azure PaaS services.
- Link one or more VNets to each zone.
- Supports optional custom zone names.
- Standardizes tags and naming using a labels module.

---

## ✅ Supported Resource Types

| Resource Type        | Private DNS Zone                           |
|----------------------|---------------------------------------------|
| `container_registry` | `privatelink.azurecr.io`                    |
| `key_vault`          | `privatelink.vaultcore.azure.net`          |
| `mysql_flexible`     | `privatelink.mysql.database.azure.com`     |


---

## ✨ Usage

```hcl
module "private_dns" {
  source  = "github.com/your-org/terraform-azurerm-paas-private-dns"
  name    = "example"
  environment = "dev"
  managedby   = "devops"
  repository  = "terraform-modules"

  resource_group_name = "rg-networking"

  private_dns_config = [
    {
      resource_type = "container_registry"
      vnet_ids      = ["/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet1"]
    },
    {
      resource_type = "key_vault"
      vnet_ids      = ["/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet2"]
    }
  ]
}

