# MySql Flexible Server

This terraform module streamlines the creation and management of azure mysql flexible servers. It provides a flexible and customizable solution for deploying fully-configured instances, incorporating best practices and offering a variety of options to suit different needs.

## Features

Manages multiple databases

Support for multiple firewall rules

Utilization of terratest for robust validation.

Provides maintenance, high availability, and robust management options.

Ability to generate a user assigned identity or bring your own if specified.

Flexible configuration of multiple server parameters

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_mysql_flexible_database.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) (resource)
- [azurerm_mysql_flexible_server.sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) (resource)
- [azurerm_mysql_flexible_server_configuration.configs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) (resource)
- [azurerm_mysql_flexible_server_firewall_rule.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_instance"></a> [instance](#input\_instance)

Description: Contains all mysql flexible server configuration

Type:

```hcl
object({
    name                              = string
    resource_group_name               = optional(string, null)
    location                          = optional(string, null)
    backup_retention_days             = optional(number, 7)
    create_mode                       = optional(string, "Default")
    delegated_subnet_id               = optional(string, null)
    geo_redundant_backup_enabled      = optional(bool, false)
    point_in_time_restore_time_in_utc = optional(string, null)
    private_dns_zone_id               = optional(string, null)
    replication_role                  = optional(string, null)
    sku_name                          = optional(string, "GP_Standard_D8ds_v4")
    source_server_id                  = optional(string, null)
    version                           = optional(string, "5.7")
    zone                              = optional(string, null)
    administrator_login               = optional(string, "adminLogin")
    administrator_password            = optional(string, null)
    tags                              = optional(map(string))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), null)
    }), null)
    storage = optional(object({
      iops               = optional(number, null)
      size_gb            = optional(number, null)
      auto_grow_enabled  = optional(bool, true)
      io_scaling_enabled = optional(bool, false)
    }), null)
    high_availability = optional(object({
      mode                      = string
      standby_availability_zone = optional(string, null)
    }), null)
    maintenance_window = optional(object({
      start_hour   = optional(number, null)
      start_minute = optional(number, null)
      day_of_week  = optional(number, null)
    }), null)
    customer_managed_key = optional(object({
      key_vault_key_id                     = optional(string, null)
      geo_backup_key_vault_key_id          = optional(string, null)
      primary_user_assigned_identity_id    = optional(string, null)
      geo_backup_user_assigned_identity_id = optional(string, null)
    }), null)
    databases = optional(map(object({
      name      = optional(string, null)
      collation = string
      charset   = string
    })), {})
    firewall_rules = optional(map(object({
      name             = optional(string, null)
      start_ip_address = string
      end_ip_address   = string
    })), {})
    configurations = optional(map(object({
      name  = string
      value = string
    })), {})
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: used for naming purposes

Type: `map(string)`

Default: `{}`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_databases"></a> [databases](#output\_databases)

Description: Contains all mysql flexible server databases

### <a name="output_instance"></a> [instance](#output\_instance)

Description: Contains all mysql flexible server configuration
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-mysql/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-mysql" />
</a>

## License

MIT Licensed. See [LICENSE](https://github.com/cloudnationhq/terraform-azure-mysql/blob/main/LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/mysql/flexible-server/overview)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/mysql/)
