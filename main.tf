resource "azurerm_key_vault_secret" "sql" {
  count = "${var.key_vault_uri != "" ? 1 : 0 }"

  name      = "sql-server-password"
  value     = "${random_string.password.result}"
  vault_uri = "${var.key_vault_uri}"
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "${var.server_name}-${var.environment}-sql"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "${var.admin_login_name}"
  administrator_login_password = "${random_string.password.result}"
}

resource "azurerm_sql_firewall_rule" "sql_firewall" {
  count = "${var.allow_azure_ip_access ? 1 : 0}"

  name                = "AllowAccessToAzure"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.sql_server.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_active_directory_administrator" "sql_admin" {
  server_name         = "${azurerm_sql_server.sql_server.name}"
  resource_group_name = "${var.resource_group_name}"
  login               = "${var.ad_admin_login_name}"
  tenant_id           = "${var.ad_admin_tenant_id}"
  object_id           = "${var.ad_admin_object_id}"
}

resource "azurerm_sql_database" "sql_database" {
  name                = "${var.database_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.sql_server.name}"

  tags = "${merge(var.tags, map("environment", var.environment), map("release", var.release))}"
}

resource "random_string" "password" {
  length           = 32
  special          = true
  override_special = "/@\" "
}
