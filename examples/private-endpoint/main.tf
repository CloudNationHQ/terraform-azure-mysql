module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.32"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "swedencentral"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 10.0"


  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.19.0.0/16"]

    subnets = {
      mysql = {
        address_prefixes = ["10.19.1.0/24"]
        delegations = {
          mysql = {
            name = "Microsoft.DBforMySQL/flexibleServers"
            actions = [
              "Microsoft.Network/virtualNetworks/subnets/join/action"
            ]
          }
        }
      }
    }
  }
}

module "private_dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 5.0"

  resource_group_name = module.rg.groups.demo.name

  zones = {
    private = {
      mysql = {
        name = "privatelink.mysql.database.azure.com"
        virtual_network_links = {
          link1 = {
            virtual_network_id   = module.network.vnet.id
            registration_enabled = false
          }
        }
      }
    }
  }
}

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 6.0"


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

module "mysql" {
  source  = "cloudnationhq/mysql/azure"
  version = "~> 4.0"

  mysql_flexible_server = {
    name                   = module.naming.mysql_server.name_unique
    location               = module.rg.groups.demo.location
    resource_group_name    = module.rg.groups.demo.name
    administrator_password = module.kv.secrets.db.value
    administrator_login    = "adminLogin"
    sku_name               = "GP_Standard_D8ds_v4"
    version                = "8.0.21"
    delegated_subnet_id    = module.network.subnets.mysql.id
    private_dns_zone_id    = module.private_dns.private_zones.mysql.id
    public_network_access  = "Disabled"
  }

  depends_on = [module.private_dns]
}
