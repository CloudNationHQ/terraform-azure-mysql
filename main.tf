# mysql server
resource "azurerm_mysql_flexible_server" "sql" {
  name                              = var.instance.name
  resource_group_name               = coalesce(lookup(var.instance, "resource_group", null), var.resource_group)
  location                          = coalesce(lookup(var.instance, "location", null), var.location)
  backup_retention_days             = try(var.instance.backup_retention_days, 7)
  create_mode                       = try(var.instance.create_mode, "Default")
  delegated_subnet_id               = try(var.instance.delegated_subnet_id, null)
  geo_redundant_backup_enabled      = try(var.instance.geo_redundant_backup_enabled, false)
  point_in_time_restore_time_in_utc = try(var.instance.point_in_time_restore_time_in_utc, null)
  private_dns_zone_id               = try(var.instance.private_dns_zone_id, null)
  replication_role                  = try(var.instance.replication_role, null)
  sku_name                          = try(var.instance.sku_name, "GP_Standard_D8ds_v4")
  source_server_id                  = try(var.instance.source_server_id, null)
  version                           = try(var.instance.version, "5.7")
  zone                              = try(var.instance.zone, null)
  administrator_login               = try(var.instance.administrator_login, "adminLogin")
  administrator_password            = var.instance.administrator_password
  tags                              = try(var.instance.tags, var.tags, null)

  dynamic "identity" {
    for_each = lookup(var.instance, "identity", null) != null ? [lookup(var.instance, "identity", {})] : []
    content {
      type = "UserAssigned"
      identity_ids = lookup(
        identity.value, "identity_ids", null
        ) != null ? identity.value.identity_ids : [
        for uai in azurerm_user_assigned_identity.identity : uai.id
      ]
    }
  }

  dynamic "storage" {
    for_each = try(var.instance.storage, null) != null ? { "default" = var.instance.storage } : {}

    content {
      iops               = try(storage.value.iops, null)
      size_gb            = try(storage.value.size_gb, null)
      auto_grow_enabled  = try(storage.value.auto_grow_enabled, true)
      io_scaling_enabled = try(storage.value.io_scaling_enabled, false)
    }
  }

  dynamic "high_availability" {
    for_each = try(var.instance.high_availability, null) != null ? { "default" = var.instance.high_availability } : {}

    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = try(high_availability.value.standby_availability_zone, null)
    }
  }

  dynamic "maintenance_window" {
    for_each = try(var.instance.maintenance_window, null) != null ? { "default" = var.instance.maintenance_window } : {}

    content {
      start_hour   = try(maintenance_window.value.start_hour, null)
      start_minute = try(maintenance_window.value.start_minute, null)
      day_of_week  = try(maintenance_window.value.day_of_week, null)
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(var.instance.customer_managed_key, null) != null ? { "default" = var.instance.customer_managed_key } : {}

    content {
      key_vault_key_id                     = try(customer_managed_key.value.key_vault_key_id, null)
      geo_backup_key_vault_key_id          = try(customer_managed_key.value.geo_backup_key_vault_key_id, null)
      primary_user_assigned_identity_id    = try(customer_managed_key.value.primary_user_assigned_identity_id, null)
      geo_backup_user_assigned_identity_id = try(customer_managed_key.value.geo_backup_user_assigned_identity_id, null)
    }
  }
}

# databases
resource "azurerm_mysql_flexible_database" "db" {
  for_each = lookup(
    var.instance, "databases", null
  ) != null ? var.instance.databases : {}

  name                = try(each.value.name, join("-", [var.naming.mysql_database, each.key]))
  resource_group_name = coalesce(lookup(var.instance, "resource_group", null), var.resource_group)
  server_name         = azurerm_mysql_flexible_server.sql.name
  collation           = each.value.collation
  charset             = each.value.charset
}

# firewall rules
resource "azurerm_mysql_flexible_server_firewall_rule" "rules" {
  for_each = lookup(
    var.instance, "firewall_rules", null
  ) != null ? var.instance.firewall_rules : {}

  name                = try(each.value.name, join("-", [var.naming.mysql_firewall_rule, each.key]))
  resource_group_name = coalesce(lookup(var.instance, "resource_group", null), var.resource_group)
  server_name         = azurerm_mysql_flexible_server.sql.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}

# configurations
resource "azurerm_mysql_flexible_server_configuration" "configs" {
  for_each = lookup(
    var.instance, "configurations", null
  ) != null ? var.instance.configurations : {}

  name                = each.value.name
  resource_group_name = coalesce(lookup(var.instance, "resource_group", null), var.resource_group)
  server_name         = azurerm_mysql_flexible_server.sql.name
  value               = each.value.value
}

resource "azurerm_user_assigned_identity" "identity" {
  for_each = lookup(var.instance, "identity", null) != null ? (
    lookup(var.instance.identity, "identity_ids", null) == null ? { "identity" = var.instance.identity } : {}
  ) : {}

  name                = lookup(each.value, "name", "uai-${var.instance.name}")
  location            = coalesce(lookup(each.value, "location", null), var.instance.location)
  resource_group_name = coalesce(lookup(each.value, "resource_group", null), var.instance.resource_group)
  tags                = try(var.instance.tags, var.tags, null)
}
