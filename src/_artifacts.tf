locals {
  data_infrastructure = {
    ari = azurerm_mysql_flexible_server.main.id
  }
  data_authentication = {
    username = azurerm_mysql_flexible_server.main.administrator_login
    password = azurerm_mysql_flexible_server.main.administrator_password
    hostname = azurerm_mysql_flexible_server.main.fqdn
    port     = 3306
  }
  data_security = {}
}

resource "massdriver_artifact" "authentication" {
  field    = "authentication"
  name     = "MySQL Server ${var.md_metadata.name_prefix} (${azurerm_mysql_flexible_server.main.id})"
  artifact = jsonencode(
    {
      data = {
        infrastructure = local.data_infrastructure
        authentication = local.data_authentication
        security       = local.data_security
      }
      specs = {
        rdbms = {
          engine  = "MySQL"
          version = azurerm_mysql_flexible_server.main.version
        }
      }
    }
  )
}
