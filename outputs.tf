output "instance" {
  description = "Contains all mysql flexible server configuration"
  value       = azurerm_mysql_flexible_server.sql
}

output "databases" {
  description = "Contains all mysql flexible server databases"
  value       = azurerm_mysql_flexible_database.db
}

output "firewall_rules" {
  description = "Contains all mysql flexible server firewall rules"
  value       = azurerm_mysql_flexible_server_firewall_rule.rules
}

output "configurations" {
  description = "Contains all mysql flexible server configurations"
  value       = azurerm_mysql_flexible_server_configuration.configs
}
