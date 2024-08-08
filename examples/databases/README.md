# Databases

This deploys databases withing a mysql flexible server.

## types

```hcl
instance = object({
  name                   = string
  location               = string
  resource_group         = string
  administrator_password = string
  databases = optional(map(object({
    collation = string
    charset   = string
  })))
})
```
