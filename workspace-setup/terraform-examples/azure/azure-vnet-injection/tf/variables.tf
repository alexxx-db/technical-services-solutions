# =============================================================================
# Azure Configuration
# =============================================================================

variable "tenant_id" {
  description = "Your Azure Tenant ID"
  type        = string
}

variable "azure_subscription_id" {
  description = "Your Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "managed_resource_group_name" {
  description = "The name of managed resource group. This is optional field. Must differ from resource_group_name."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

# =============================================================================
# Databricks Configuration
# =============================================================================

variable "databricks_account_id" {
  description = "ID of the Databricks account"
  type        = string
  sensitive   = true
}

variable "workspace_name" {
  description = "The name of the Databricks workspace"
  type        = string
}

variable "admin_user" {
  description = "The email of the user to assign admin access to the workspace and the new metastore"
  type        = string
}

variable "root_storage_name" {
  type        = string
  description = "The root storage name. Only lowercase letters and numbers, 3-24 characters."
  validation {
    condition     = length(var.root_storage_name) >= 3 && length(var.root_storage_name) <= 24
    error_message = "root_storage_name must be between 3 and 24 characters."
  }
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.root_storage_name))
    error_message = "root_storage_name can only contain lowercase letters and numbers."
  }
}

variable "location" {
  description = "The Azure region to deploy the workspace to"
  type        = string
  validation {
    condition = contains([
      "australiacentral", "australiacentral2", "australiaeast", "australiasoutheast", "brazilsouth", "canadacentral", "canadaeast", "centralindia", "centralus", "chinaeast2", "chinaeast3", "chinanorth2", "chinanorth3", "eastasia", "eastus", "eastus2", "francecentral", "germanywestcentral", "japaneast", "japanwest", "koreacentral", "mexicocentral", "northcentralus", "northeurope", "norwayeast", "qatarcentral", "southafricanorth", "southcentralus", "southeastasia", "southindia", "swedencentral", "switzerlandnorth", "switzerlandwest", "uaenorth", "uksouth", "ukwest", "westcentralus", "westeurope", "westindia", "westus", "westus2", "westus3"
    ], var.location)
    error_message = "Valid values for var.location are standard Azure regions supported by Databricks."
  }
}

variable "existing_metastore_id" {
  description = "The ID of the existing metastore. Leave empty to create a new metastore."
  type        = string
  default     = ""
}

variable "new_metastore_name" {
  description = "The name of the new metastore."
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]*$", var.new_metastore_name))
    error_message = "metastore_name can only contain alphanumerical characters, hyphens, and underscores."
  }
}

# =============================================================================
# Network Configuration
# =============================================================================

variable "create_new_vnet" {
  description = "Whether to create a new VNet"
  type        = bool
  default     = true
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_resource_group_name" {
  description = "The name of the VNet resource group"
  type        = string
}

variable "cidr" {
  description = "The CIDR address of the virtual network"
  type        = string
  default     = "10.0.0.0/20"
  validation {
    condition     = can(cidrhost(var.cidr, 0))
    error_message = "cidr must be a valid CIDR block (e.g., 10.0.0.0/20)."
  }
}

variable "subnet_public_cidr" {
  description = "The CIDR address of the public (host) subnet"
  type        = string
  validation {
    condition     = can(cidrhost(var.subnet_public_cidr, 0))
    error_message = "subnet_public_cidr must be a valid CIDR block."
  }
}

variable "subnet_private_cidr" {
  description = "The CIDR address of the private (container) subnet"
  type        = string
  validation {
    condition     = can(cidrhost(var.subnet_private_cidr, 0))
    error_message = "subnet_private_cidr must be a valid CIDR block."
  }
}
