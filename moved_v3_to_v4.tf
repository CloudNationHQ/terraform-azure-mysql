moved {
  from = azurerm_mysql_flexible_server.sql
  to   = azurerm_mysql_flexible_server.this
}

moved {
  from = azurerm_mysql_flexible_database.db
  to   = azurerm_mysql_flexible_database.this
}

moved {
  from = azurerm_mysql_flexible_server_firewall_rule.rules
  to   = azurerm_mysql_flexible_server_firewall_rule.this
}

moved {
  from = azurerm_mysql_flexible_server_configuration.configs
  to   = azurerm_mysql_flexible_server_configuration.this
}
