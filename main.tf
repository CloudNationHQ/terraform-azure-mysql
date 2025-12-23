# mysql server
resource "azurerm_mysql_flexible_server" "sql" {
  resource_group_name = coalesce(
    lookup(
      var.instance, "resource_group_name", null
    ), var.resource_group_name
  )

  location = coalesce(
    lookup(var.instance, "location", null
    ), var.location
  )

  name                              = var.instance.name
  backup_retention_days             = var.instance.backup_retention_days
  create_mode                       = var.instance.create_mode
  delegated_subnet_id               = var.instance.delegated_subnet_id
  geo_redundant_backup_enabled      = var.instance.geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = var.instance.point_in_time_restore_time_in_utc
  private_dns_zone_id               = var.instance.private_dns_zone_id
  replication_role                  = var.instance.replication_role
  sku_name                          = var.instance.sku_name
  source_server_id                  = var.instance.source_server_id
  version                           = var.instance.version
  zone                              = var.instance.zone
  administrator_login               = var.instance.administrator_login
  administrator_password            = var.instance.administrator_password
  administrator_password_wo         = var.instance.administrator_password_wo
  administrator_password_wo_version = var.instance.administrator_password_wo_version
  public_network_access             = var.instance.public_network_access

  tags = coalesce(
    var.instance.tags, var.tags
  )

  dynamic "identity" {
    for_each = lookup(var.instance, "identity", null) != null ? [var.instance.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "storage" {
    for_each = try(var.instance.storage, null) != null ? { "default" = var.instance.storage } : {}

    content {
      iops                = storage.value.iops
      size_gb             = storage.value.size_gb
      auto_grow_enabled   = storage.value.auto_grow_enabled
      io_scaling_enabled  = storage.value.io_scaling_enabled
      log_on_disk_enabled = storage.value.log_on_disk_enabled
    }
  }

  dynamic "high_availability" {
    for_each = try(var.instance.high_availability, null) != null ? { "default" = var.instance.high_availability } : {}

    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }

  dynamic "maintenance_window" {
    for_each = try(var.instance.maintenance_window, null) != null ? { "default" = var.instance.maintenance_window } : {}

    content {
      start_hour   = maintenance_window.value.start_hour
      start_minute = maintenance_window.value.start_minute
      day_of_week  = maintenance_window.value.day_of_week
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(var.instance.customer_managed_key, null) != null ? { "default" = var.instance.customer_managed_key } : {}

    content {
      key_vault_key_id                     = customer_managed_key.value.key_vault_key_id
      geo_backup_key_vault_key_id          = customer_managed_key.value.geo_backup_key_vault_key_id
      primary_user_assigned_identity_id    = customer_managed_key.value.primary_user_assigned_identity_id
      geo_backup_user_assigned_identity_id = customer_managed_key.value.geo_backup_user_assigned_identity_id
      managed_hsm_key_id                   = customer_managed_key.value.managed_hsm_key_id
    }
  }
}

# databases
resource "azurerm_mysql_flexible_database" "db" {
  for_each = lookup(var.instance, "databases", null) != null ? var.instance.databases : {}

  resource_group_name = coalesce(
    lookup(
      var.instance, "resource_group_name", null
    ), var.resource_group_name
  )

  name = coalesce(
    each.value.name, join("-", [var.naming.mysql_database, each.key])
  )

  server_name = azurerm_mysql_flexible_server.sql.name
  collation   = each.value.collation
  charset     = each.value.charset
}

# firewall rules
resource "azurerm_mysql_flexible_server_firewall_rule" "rules" {
  for_each = lookup(var.instance, "firewall_rules", null) != null ? var.instance.firewall_rules : {}

  resource_group_name = coalesce(
    lookup(
      var.instance, "resource_group_name", null
    ), var.resource_group_name
  )

  name = coalesce(
    each.value.name, join("-", [var.naming.mysql_firewall_rule, each.key])
  )

  server_name      = azurerm_mysql_flexible_server.sql.name
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

# configurations
resource "azurerm_mysql_flexible_server_configuration" "configs" {
  for_each = lookup(var.instance, "configurations", null) != null ? var.instance.configurations : {}

  resource_group_name = coalesce(
    lookup(
      var.instance, "resource_group_name", null
    ), var.resource_group_name
  )

  name        = each.value.name
  server_name = azurerm_mysql_flexible_server.sql.name
  value       = each.value.value
}
