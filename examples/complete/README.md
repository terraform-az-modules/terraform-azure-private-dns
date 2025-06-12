<!-- BEGIN_TF_DOCS -->

# Azure Private DNS with VNet Integration

This example provisions a Private DNS Zone in Azure and links it to a Virtual Network using the `terraform-azure-private-dns` module.

---

## ✅ Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.6.6  |
| Azurerm   | >= 3.116.0 |

---

## 🔌 Providers

_No providers are explicitly defined in this example._

---

## 📦 Modules

| Name           | Source                         | Version |
|----------------|--------------------------------|---------|
| private_dns    | ../..                          | n/a     |
| resource_group | terraform-az-modules/resource-group/azure | 1.0.0   |
| vnet           | "terraform-az-modules/vnet/azure"           | 1.0.0   |

---

## 🏗️ Resources

_No standalone resources are declared in this example._

---

## 🔧 Inputs

_No input variables are defined in this example._

---

## 📤 Outputs

| Name                        | Description                          |
|-----------------------------|--------------------------------------|
| `dns_zone_id_keyvault`      | The ID of the Private DNS Zone for Key Vault |
| `dns_zone_name_keyvault`    | The name of the Private DNS Zone  for Key Vault    |
| `dns_zone_id_storage`      | The ID of the Private DNS Zone for Storage Account |
| `dns_zone_name_storage`    | The name of the Private DNS Zone  for Storage Account    |

<!-- END_TF_DOCS -->
