# High Availability

This configures high availability on the mysql flexible server.

## types

```hcl
instance = object({
  name                   = string
  location               = string
  resource_group         = string
  administrator_password = string
  zone                   = optional(string)
  high_availability = optional(object({
    mode                      = string
    standby_availability_zone = optional(string)
  }))
})
```
