output "mysql_flexible_server" {
  description = "Contains all mysql flexible server configuration"
  value       = azurerm_mysql_flexible_server.this
}

output "databases" {
  description = "Contains all mysql flexible server databases"
  value       = azurerm_mysql_flexible_database.this
}

output "firewall_rules" {
  description = "Contains all mysql flexible server firewall rules"
  value       = azurerm_mysql_flexible_server_firewall_rule.this
}

output "configurations" {
  description = "Contains all mysql flexible server configurations"
  value       = azurerm_mysql_flexible_server_configuration.this
}
