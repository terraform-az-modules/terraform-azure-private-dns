## -----------------------------------------------------------------------------
## Labels
## -----------------------------------------------------------------------------
variable "name" {
  type        = string
  default     = null
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "location" {
  type        = string
  default     = null
  description = "Azure region (e.g. `eastus`, `westus`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azure-private-dns"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(string)
  default     = ["name", "environment", "location"]
  description = "The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

## -----------------------------------------------------------------------------
## Private DNS Configuration
## -----------------------------------------------------------------------------
variable "enable" {
  type        = bool
  default     = true
  description = "Flag to enable or disable the module. Set to false to skip all resources."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group in which private DNS zones will be created."
}

variable "private_dns_config" {
  type = list(object({
    resource_type = string
    vnet_ids      = list(string)
    zone_name     = optional(string)
  }))
  default     = []
  description = <<EOT
List of private DNS zone configurations for supported Azure PaaS services.

Each object supports:
- resource_type: (Required) Type of PaaS resource (e.g., 'container_registry', 'key_vault').
- vnet_ids:      (Required) List of VNet resource IDs to link to the private DNS zone.
- zone_name:     (Optional) Custom DNS zone name. If not provided, defaults will be used based on resource_type.
EOT
}