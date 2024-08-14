module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "prd"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 0.1"

  groups = {
    demo = {
      name   = module.naming.resource_group.name
      region = "northeurope"
    }
  }
}

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 0.1"

  naming = local.naming

  vault = {
    name          = module.naming.key_vault.name_unique
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name

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
  version = "~> 0.1"

  naming = local.naming

  instance = {
    name                   = module.naming.mysql_server.name_unique
    location               = module.rg.groups.demo.location
    resource_group         = module.rg.groups.demo.name
    administrator_password = module.kv.secrets.db.value

    databases = {
      user = {
        collation = "utf8_unicode_ci"
        charset   = "utf8"
      }
      orders = {
        collation = "utf8_unicode_ci"
        charset   = "utf8"
      }
    }
  }
}
