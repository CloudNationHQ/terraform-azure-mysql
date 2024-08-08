output "server" {
  description = "describes mysql flexible server related configuration"
  value       = azurerm_mysql_flexible_server.sql
}

output "databases" {
  description = "contains databases"
  value       = azurerm_mysql_flexible_database.db
}
