# Firewall Rules

This deploys multiple firewall rules.

## types

```hcl
instance = object({
  name                   = string
  location               = string
  resource_group         = string
  administrator_password = string
  firewall_rules = optional(map(object({
    start_ip_address = string
    end_ip_address   = string
  })))
})
```
