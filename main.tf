# mysql server
resource "azurerm_mysql_flexible_server" "this" {
  resource_group_name = coalesce(
    var.mysql_flexible_server.resource_group_name, var.resource_group_name
  )

  location = coalesce(
    var.mysql_flexible_server.location, var.location
  )

  name                              = var.mysql_flexible_server.name
  backup_retention_days             = var.mysql_flexible_server.backup_retention_days
  create_mode                       = var.mysql_flexible_server.create_mode
  delegated_subnet_id               = var.mysql_flexible_server.delegated_subnet_id
  geo_redundant_backup_enabled      = var.mysql_flexible_server.geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = var.mysql_flexible_server.point_in_time_restore_time_in_utc
  private_dns_zone_id               = var.mysql_flexible_server.private_dns_zone_id
  replication_role                  = var.mysql_flexible_server.replication_role
  sku_name                          = var.mysql_flexible_server.sku_name
  source_server_id                  = var.mysql_flexible_server.source_server_id
  version                           = var.mysql_flexible_server.version
  zone                              = var.mysql_flexible_server.zone
  administrator_login               = var.mysql_flexible_server.administrator_login
  administrator_password            = var.mysql_flexible_server.administrator_password
  administrator_password_wo         = var.mysql_flexible_server.administrator_password_wo
  administrator_password_wo_version = var.mysql_flexible_server.administrator_password_wo_version
  public_network_access             = var.mysql_flexible_server.public_network_access

  tags = coalesce(
    var.mysql_flexible_server.tags, var.tags
  )

  dynamic "identity" {
    for_each = var.mysql_flexible_server.identity != null ? { "this" = var.mysql_flexible_server.identity } : {}

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "storage" {
    for_each = var.mysql_flexible_server.storage != null ? { "this" = var.mysql_flexible_server.storage } : {}

    content {
      iops                = storage.value.iops
      size_gb             = storage.value.size_gb
      auto_grow_enabled   = storage.value.auto_grow_enabled
      io_scaling_enabled  = storage.value.io_scaling_enabled
      log_on_disk_enabled = storage.value.log_on_disk_enabled
    }
  }

  dynamic "high_availability" {
    for_each = var.mysql_flexible_server.high_availability != null ? { "this" = var.mysql_flexible_server.high_availability } : {}

    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }

  dynamic "maintenance_window" {
    for_each = var.mysql_flexible_server.maintenance_window != null ? { "this" = var.mysql_flexible_server.maintenance_window } : {}

    content {
      start_hour   = maintenance_window.value.start_hour
      start_minute = maintenance_window.value.start_minute
      day_of_week  = maintenance_window.value.day_of_week
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.mysql_flexible_server.customer_managed_key != null ? { "this" = var.mysql_flexible_server.customer_managed_key } : {}

    content {
      key_vault_key_id                     = customer_managed_key.value.key_vault_key_id
      geo_backup_key_vault_key_id          = customer_managed_key.value.geo_backup_key_vault_key_id
      primary_user_assigned_identity_id    = customer_managed_key.value.primary_user_assigned_identity_id
      geo_backup_user_assigned_identity_id = customer_managed_key.value.geo_backup_user_assigned_identity_id
    }
  }
}

# databases
resource "azurerm_mysql_flexible_database" "this" {
  for_each = var.mysql_flexible_server.databases

  resource_group_name = coalesce(
    var.mysql_flexible_server.resource_group_name, var.resource_group_name
  )

  name = coalesce(
    each.value.name, each.key
  )

  server_name = azurerm_mysql_flexible_server.this.name
  collation   = each.value.collation
  charset     = each.value.charset
}

# firewall rules
resource "azurerm_mysql_flexible_server_firewall_rule" "this" {
  for_each = var.mysql_flexible_server.firewall_rules

  resource_group_name = coalesce(
    var.mysql_flexible_server.resource_group_name, var.resource_group_name
  )

  name = coalesce(
    each.value.name, each.key
  )

  server_name      = azurerm_mysql_flexible_server.this.name
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

# configurations
resource "azurerm_mysql_flexible_server_configuration" "this" {
  for_each = var.mysql_flexible_server.configurations

  resource_group_name = coalesce(
    var.mysql_flexible_server.resource_group_name, var.resource_group_name
  )

  name        = each.value.name
  server_name = azurerm_mysql_flexible_server.this.name
  value       = each.value.value
}
