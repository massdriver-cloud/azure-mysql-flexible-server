// Auto-generated variable declarations from massdriver.yaml
variable "azure_service_principal" {
  type = object({
    data = object({
      client_id       = string
      client_secret   = string
      subscription_id = string
      tenant_id       = string
    })
    specs = object({})
  })
}
variable "azure_virtual_network" {
  type = object({
    data = object({
      infrastructure = object({
        cidr              = string
        default_subnet_id = string
        id                = string
      })
    })
    specs = optional(object({
      azure = optional(object({
        region = string
      }))
    }))
  })
}
variable "backup" {
  type = object({
    backup_retention_days = optional(number)
  })
}
variable "database" {
  type = object({
    high_availability = optional(bool)
    mysql_version     = string
    sku_name          = string
    storage_gb        = number
    username          = string
  })
}
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "monitoring" {
  type = object({
    mode = optional(string)
    alarms = optional(object({
      cpu_metric_alert = optional(object({
        aggregation = string
        frequency   = string
        operator    = string
        severity    = number
        threshold   = number
        window_size = string
      }))
      memory_metric_alert = optional(object({
        aggregation = string
        frequency   = string
        operator    = string
        severity    = number
        threshold   = number
        window_size = string
      }))
      storage_metric_alert = optional(object({
        aggregation = string
        frequency   = string
        operator    = string
        severity    = number
        threshold   = number
        window_size = string
      }))
    }))
  })
}
variable "network" {
  type = object({
    auto = optional(bool)
    cidr = optional(string)
  })
}
