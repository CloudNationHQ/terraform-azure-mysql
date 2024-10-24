module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "northeurope"
    }
  }
}

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 2.0"

  naming = local.naming

  vault = {
    name           = module.naming.key_vault.name_unique
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    secrets = {
      random_string = {
        db = {
          length  = 24
          special = true
        }
      }
    }
  }
}

module "mysql" {
  source  = "cloudnationhq/mysql/azure"
  version = "~> 1.0"

  naming = local.naming

  instance = {
    name                   = module.naming.mysql_server.name
    location               = module.rg.groups.demo.location
    resource_group         = module.rg.groups.demo.name
    administrator_password = module.kv.secrets.db.value

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
  }
}
