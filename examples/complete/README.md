# Complete

This example highlights the complete usage.

## Types

```hcl
instance = object({
  name                   = string
  location               = string
  resource_group         = string
  administrator_password = string
  zone                   = optional(string)
  configurations = optional(map(object({
    name  = string
    value = string
  })))
  identity = optional(object({
    type = string
  }))
  maintenance_window = optional(object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  }))
  high_availability = optional(object({
    mode                      = string
    standby_availability_zone = string
  }))
  storage = optional(object({
    iops    = number
    size_gb = number
  }))
  databases = optional(map(object({
    collation = string
    charset   = string
  })))
  firewall_rules = optional(map(object({
    start_ip_address = string
    end_ip_address   = string
  })))
})
```

## Notes

When setting the identity type to UserAssigned, the module will generate a user-assigned identity automatically.

However, if you specify identities under the identity_ids property, the module will skip the generating one, and your specified identities will be used instead.
