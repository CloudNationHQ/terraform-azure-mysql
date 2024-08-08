# Configurations

This deploys server configurations.

## types

```hcl
instance = object({
  name                   = string
  location               = string
  resource_group         = string
  administrator_password = string
  configurations = optional(map(object({
    name  = string
    value = string
  })))
})
```
