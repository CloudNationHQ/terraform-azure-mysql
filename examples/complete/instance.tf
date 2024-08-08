locals {
  instance = {
    name                   = module.naming.mysql_server.name
    location               = module.rg.groups.demo.location
    resource_group         = module.rg.groups.demo.name
    administrator_password = module.kv.secrets.db.value
    zone                   = "1"

    configurations = {
      slow_query_log = {
        name  = "slow_query_log"
        value = "ON"
      }
      long_query_time = {
        name  = "long_query_time"
        value = "2"
      }
      max_connections = {
        name  = "max_connections"
        value = "200"
      }
    }

    identity = {
      type = "UserAssigned"
    }

    maintenance_window = {
      day_of_week  = 1
      start_hour   = 2
      start_minute = 0
    }

    high_availability = {
      mode                      = "ZoneRedundant"
      standby_availability_zone = "2"
    }

    storage = {
      iops    = 1000
      size_gb = 512
    }

    databases = {
      user = {
        collation = "utf8_unicode_ci"
        charset   = "utf8"
      }
    }

    firewall_rules = {
      sales = {
        start_ip_address = "10.20.30.1"
        end_ip_address   = "10.20.30.255"
      }
    }
  }
}
