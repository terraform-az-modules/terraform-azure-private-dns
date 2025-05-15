## -----------------------------------------------------------------------------
## General Configuration
## -----------------------------------------------------------------------------

variable "enable" {
  type        = bool
  default     = true
  description = "Flag to enable or disable the module. Set to false to skip all resources."
}

variable "name" {
  type        = string
  default     = ""
  description = "The base name used for resources (e.g., 'app' or 'cluster')."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Deployment environment (e.g., 'prod', 'dev', 'staging')."
}

variable "managedby" {
  type        = string
  default     = ""
  description = "Name of the entity or team managing the resource (e.g., 'DevOps')."
}

variable "repository" {
  type        = string
  default     = ""
  description = "URL or name of the repository containing the module source code."
}

variable "label_order" {
  type        = list(string)
  default     = ["name", "environment"]
  description = "The order in which labels are applied. Example: ['name', 'environment']."
}

## -----------------------------------------------------------------------------
## Azure Resource Configuration
## -----------------------------------------------------------------------------

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