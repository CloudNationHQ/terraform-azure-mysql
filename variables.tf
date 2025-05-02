variable "instance" {
  description = "Contains all mysql flexible server configuration"
  type = object({
    name                              = string
    resource_group_name               = optional(string, null)
    location                          = optional(string, null)
    backup_retention_days             = optional(number, 7)
    create_mode                       = optional(string, "Default")
    delegated_subnet_id               = optional(string, null)
    geo_redundant_backup_enabled      = optional(bool, false)
    point_in_time_restore_time_in_utc = optional(string, null)
    private_dns_zone_id               = optional(string, null)
    replication_role                  = optional(string, null)
    sku_name                          = optional(string, "GP_Standard_D8ds_v4")
    source_server_id                  = optional(string, null)
    version                           = optional(string, "5.7")
    zone                              = optional(string, null)
    administrator_login               = optional(string, "adminLogin")
    administrator_password            = optional(string, null)
    administrator_password_wo         = optional(string, null)
    administrator_password_wo_version = optional(number, null)
    public_network_access             = optional(string, "Enabled")
    tags                              = optional(map(string))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), null)
    }), null)
    storage = optional(object({
      iops                = optional(number, null)
      size_gb             = optional(number, null)
      auto_grow_enabled   = optional(bool, true)
      io_scaling_enabled  = optional(bool, false)
      log_on_disk_enabled = optional(bool, false)
    }), null)
    high_availability = optional(object({
      mode                      = string
      standby_availability_zone = optional(string, null)
    }), null)
    maintenance_window = optional(object({
      start_hour   = optional(number, null)
      start_minute = optional(number, null)
      day_of_week  = optional(number, null)
    }), null)
    customer_managed_key = optional(object({
      key_vault_key_id                     = optional(string, null)
      geo_backup_key_vault_key_id          = optional(string, null)
      primary_user_assigned_identity_id    = optional(string, null)
      geo_backup_user_assigned_identity_id = optional(string, null)
    }), null)
    databases = optional(map(object({
      name      = optional(string, null)
      collation = string
      charset   = string
    })), {})
    firewall_rules = optional(map(object({
      name             = optional(string, null)
      start_ip_address = string
      end_ip_address   = string
    })), {})
    configurations = optional(map(object({
      name  = string
      value = string
    })), {})
  })

  validation {
    condition     = var.instance.location != null || var.location != null
    error_message = "Location must be provided either in the instance object or as a separate variable."
  }

  validation {
    condition     = var.instance.resource_group_name != null || var.resource_group_name != null
    error_message = "Resource group name must be provided either in the instance object or as a separate variable."
  }
}

variable "naming" {
  description = "used for naming purposes"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
