output "admin_password" {
  description = "Password for admin on the sql server."
  value = "${random_string.password.result}"
  sensitive = true
}

output "sql_server_name" {
  description = "Name of the server created. Use this if more databases needs to be added to the server. "
  value = "${azurerm_sql_server.sql_server.name}"
}