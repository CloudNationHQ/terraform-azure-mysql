module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.26"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "swedencentral"
    }
  }
}

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 4.0"

  naming = local.naming

  vault = {
    name                = module.naming.key_vault.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

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

resource "azurerm_user_assigned_identity" "mysql" {
  name                = module.naming.user_assigned_identity.name_unique
  location            = module.rg.groups.demo.location
  resource_group_name = module.rg.groups.demo.name
}

data "azuread_group" "db_admin" {
  display_name = "db-administrators"
}

module "mysql" {
  source  = "cloudnationhq/mysql/azure"
  version = "~> 3.0"

  naming = local.naming

  instance = {
    name                   = module.naming.mysql_server.name_unique
    location               = module.rg.groups.demo.location
    resource_group_name    = module.rg.groups.demo.name
    administrator_password = module.kv.secrets.db.value

    identity = {
      type         = "UserAssigned"
      identity_ids = [azurerm_user_assigned_identity.mysql.id]
    }

    ad_admin = {
      login        = data.azuread_group.db_admin.display_name
      object_id    = data.azuread_group.db_admin.object_id
      identity_id  = azurerm_user_assigned_identity.mysql.id
      principal_id = azurerm_user_assigned_identity.mysql.principal_id
    }
  }
}
