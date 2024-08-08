# Maintenance

This deploys maintenance configuration within mysql flexible server

## types

```hcl
instance = object({
  name                   = string
  location               = string
  resource_group         = string
  administrator_password = string
  maintenance_window = optional(object({
    day_of_week  = optional(number)
    start_hour   = optional(number)
    start_minute = optional(number)
  }))
})
```
