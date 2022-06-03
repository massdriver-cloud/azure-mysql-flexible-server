locals {
  size_map = {
    "B1ms (1 vCore, 2 GiB memory, 640 max iops)"        = "B_Standard_B1ms"
    "B2s (2 vCores, 4 GiB memory, 1280 max iops)"       = "B_Standard_B2s"
    "B2ms (2 vCores, 8 GiB memory, 1780 max iops)"      = "B_Standard_B2ms"
    "B4ms (4 vCores, 16 GiB memory, 2400 max iops)"     = "B_Standard_B4ms"
    "B8ms (8 vCores, 32 GiB memory, 3100 max iops)"     = "B_Standard_B8ms"
    "B16ms (16 vCores, 64 GiB memory, 4300 max iops)"   = "B_Standard_B16ms"
    "D2ds (2 vCores, 8 GiB memory, 3200 max iops)"      = "GP_Standard_D2ds_v4"
    "D4ds (4 vCores, 16 GiB memory, 6400 max iops)"     = "GP_Standard_D4ds_v4"
    "D8ds (8 vCores, 32 GiB memory, 12800 max iops)"    = "GP_Standard_D8ds_v4"
    "D16ds (16 vCores, 64 GiB memory, 18000 max iops)"  = "GP_Standard_D16ds_v4"
    "D32ds (32 vCores, 128 GiB memory, 18000 max iops)" = "GP_Standard_D32ds_v4"
    "D48ds (48 vCores, 192 GiB memory, 18000 max iops)" = "GP_Standard_D48ds_v4"
    "D64ds (64 vCores, 256 GiB memory, 18000 max iops)" = "GP_Standard_D64ds_v4"
    "E2ds (2 vCores, 16 GiB memory, 3200 max iops)"     = "MO_Standard_E2ds_v4"
    "E4ds (4 vCores, 32 GiB memory, 6400 max iops)"     = "MO_Standard_E4ds_v4"
    "E8ds (8 vCores, 64 GiB memory, 12800 max iops)"    = "MO_Standard_E8ds_v4"
    "E16ds (16 vCores, 128 GiB memory, 18000 max iops)" = "MO_Standard_E16ds_v4"
    "E32ds (32 vCores, 256 GiB memory, 18000 max iops)" = "MO_Standard_E32ds_v4"
    "E48ds (48 vCores, 384 GiB memory, 18000 max iops)" = "MO_Standard_E48ds_v4"
    "E64ds (64 vCores, 432 GiB memory, 18000 max iops)" = "MO_Standard_E64ds_v4"
  }
  sku = lookup(local.size_map, var.size, "")

  subnet_id           = var.vnet.data.infrastructure.delegated_subnets["Microsoft.DBforMySQL/flexibleServers"].subnet_id
  private_dns_zone_id = var.vnet.data.infrastructure.delegated_subnets["Microsoft.DBforMySQL/flexibleServers"].private_dns_zone_id
}

resource "random_password" "master_password" {
  length      = 16
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.vnet.specs.azure.region
}

resource "azurerm_mysql_flexible_server" "main" {
  name                   = var.md_metadata.name_prefix
  resource_group_name    = azurerm_resource_group.main.name
  location               = var.vnet.specs.azure.region
  version                = var.mysql_version
  delegated_subnet_id    = local.subnet_id
  private_dns_zone_id    = local.private_dns_zone_id
  administrator_login    = var.username
  administrator_password = random_password.master_password.result
  backup_retention_days  = var.backup_retention_days

  dynamic "high_availability" {
    for_each = var.high_availability ? toset(["enabled"]) : toset([])
    content {
      mode = "SameZone"
    }
  }
  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone
    ]
  }

  storage {
    size_gb = var.storage_size_gb
    iops    = var.iops
  }
  sku_name = local.sku
}
