variable "mysql_flexible_server" {
  description = "Contains all mysql flexible server configuration"
  type = object({
    name                              = string
    resource_group_name               = optional(string)
    location                          = optional(string)
    backup_retention_days             = optional(number)
    create_mode                       = optional(string)
    delegated_subnet_id               = optional(string)
    geo_redundant_backup_enabled      = optional(bool)
    point_in_time_restore_time_in_utc = optional(string)
    private_dns_zone_id               = optional(string)
    replication_role                  = optional(string)
    sku_name                          = optional(string)
    source_server_id                  = optional(string)
    version                           = optional(string)
    zone                              = optional(string)
    administrator_login               = optional(string)
    administrator_password            = optional(string)
    administrator_password_wo         = optional(string)
    administrator_password_wo_version = optional(number)
    public_network_access             = optional(string)
    tags                              = optional(map(string))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }), null)
    storage = optional(object({
      iops                = optional(number)
      size_gb             = optional(number)
      auto_grow_enabled   = optional(bool)
      io_scaling_enabled  = optional(bool)
      log_on_disk_enabled = optional(bool)
    }), null)
    high_availability = optional(object({
      mode                      = string
      standby_availability_zone = optional(string)
    }), null)
    maintenance_window = optional(object({
      start_hour   = optional(number)
      start_minute = optional(number)
      day_of_week  = optional(number)
    }), null)
    customer_managed_key = optional(object({
      key_vault_key_id                     = optional(string)
      geo_backup_key_vault_key_id          = optional(string)
      primary_user_assigned_identity_id    = optional(string)
      geo_backup_user_assigned_identity_id = optional(string)
    }), null)
    databases = optional(map(object({
      name      = optional(string)
      collation = string
      charset   = string
    })), {})
    firewall_rules = optional(map(object({
      name             = optional(string)
      start_ip_address = string
      end_ip_address   = string
    })), {})
    configurations = optional(map(object({
      name  = string
      value = string
    })), {})
  })

  validation {
    condition     = var.mysql_flexible_server.location != null || var.location != null
    error_message = "Location must be provided either in the instance object or as a separate variable."
  }

  validation {
    condition     = var.mysql_flexible_server.resource_group_name != null || var.resource_group_name != null
    error_message = "Resource group name must be provided either in the instance object or as a separate variable."
  }
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
