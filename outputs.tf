output "instance" {
  description = "Contains all mysql flexible server configuration"
  value       = azurerm_mysql_flexible_server.sql
}

output "databases" {
  description = "Contains all mysql flexible server databases"
  value       = azurerm_mysql_flexible_database.db
}
