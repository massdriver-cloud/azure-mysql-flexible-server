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


resource "azurerm_private_dns_zone" "main" {
  name                = "${var.md_metadata.name_prefix}-dns.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  name                  = var.md_metadata.name_prefix
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.main.name
  virtual_network_id    = var.vnet.data.infrastructure.id
}

resource "azurerm_mysql_flexible_server" "main" {
  name                   = var.md_metadata.name_prefix
  resource_group_name    = azurerm_resource_group.main.name
  location               = var.vnet.specs.azure.region
  version                = var.mysql_version
  delegated_subnet_id    = azurerm_subnet.main.id
  private_dns_zone_id    = azurerm_private_dns_zone.main.id
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
    size_gb = var.storage_gb
  }
  sku_name = var.sku_name

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.main
  ]
}