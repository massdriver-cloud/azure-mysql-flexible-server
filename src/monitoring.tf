locals {
  scope_config = {
    severity    = "1"
    frequency   = "PT1M"
    window_size = "PT5M"
  }
  metric_config = {
    operator          = "GreaterThan"
    aggregation       = "Average"
    threshold_cpu     = 90
    threshold_memory  = 90
    threshold_storage = 90
  }
}

module "cpu_metric_alert" {
  source              = "../../../provisioners/terraform/modules/azure-monitor-metrics-alarm"
  scopes              = azurerm_mysql_flexible_server.main.id
  resource_group_name = azurerm_resource_group.main.name
  severity            = local.scope_config.severity
  frequency           = local.scope_config.frequency
  window_size         = local.scope_config.window_size

  depends_on = [
    azurerm_mysql_flexible_server.main
  ]

  md_metadata     = var.md_metadata
  action_group_id = var.vnet.data.observability.alarm_monitor_action_group_ari
  message         = "High CPU Usage"

  alarm_name       = "${var.md_metadata.name_prefix}-highCPUUsage"
  operator         = local.metric_config.operator
  metric_name      = "cpu_percent"
  metric_namespace = "Microsoft.DBforMySQL/flexibleServers"
  aggregation      = local.metric_config.aggregation
  threshold        = local.metric_config.threshold_cpu
}

module "memory_metric_alert" {
  source              = "../../../provisioners/terraform/modules/azure-monitor-metrics-alarm"
  scopes              = azurerm_mysql_flexible_server.main.id
  resource_group_name = azurerm_resource_group.main.name
  severity            = local.scope_config.severity
  frequency           = local.scope_config.frequency
  window_size         = local.scope_config.window_size

  depends_on = [
    azurerm_mysql_flexible_server.main
  ]

  md_metadata     = var.md_metadata
  action_group_id = var.vnet.data.observability.alarm_monitor_action_group_ari
  message         = "High Memory Usage"

  alarm_name       = "${var.md_metadata.name_prefix}-highMemoryUsage"
  operator         = local.metric_config.operator
  metric_name      = "memory_percent"
  metric_namespace = "Microsoft.DBforMySQL/flexibleServers"
  aggregation      = local.metric_config.aggregation
  threshold        = local.metric_config.threshold_memory
}

module "storage_metric_alert" {
  source              = "../../../provisioners/terraform/modules/azure-monitor-metrics-alarm"
  scopes              = azurerm_mysql_flexible_server.main.id
  resource_group_name = azurerm_resource_group.main.name
  severity            = local.scope_config.severity
  frequency           = local.scope_config.frequency
  window_size         = local.scope_config.window_size

  depends_on = [
    azurerm_mysql_flexible_server.main
  ]

  md_metadata     = var.md_metadata
  action_group_id = var.vnet.data.observability.alarm_monitor_action_group_ari
  message         = "High Storage Usage"

  alarm_name       = "${var.md_metadata.name_prefix}-highStorageUsage"
  operator         = local.metric_config.operator
  metric_name      = "storage_percent"
  metric_namespace = "Microsoft.DBforMySQL/flexibleServers"
  aggregation      = local.metric_config.aggregation
  threshold        = local.metric_config.threshold_storage
}
