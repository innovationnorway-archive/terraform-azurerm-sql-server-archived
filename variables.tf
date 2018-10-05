variable "location" {
  default     = "westeurope"
  description = "The location where the resources should be created."
}

variable "resource_group_name" {
  description = "The resource group the sql server should be placed in. "
}

variable "environment" {
  default     = "lab"
  description = "The resource group the sql server should be placed in. "
}

variable "server_name" {
  description = "Name of the server. "
}

variable "database_name" {
  description = "Name on the initial database on the server. "
}

variable "admin_login_name" {
  default     = "kitten83"
  description = "Login name for the sql server administrator. If not set the default login name will be 'kitten83'."
}

variable "key_vault_uri" {
  default     = ""
  description = "Uri for a key vault where the module can store the sql server password. If left blank the password will not be saved automatically. "
}

variable "allow_azure_ip_access" {
  default     = "false"
  description = "If azure ip ranges should be allowed through the sql server firewall."
}

variable "ad_admin_login_name" {
  default     = "kitten82"
  description = "Name of the login for sql admin loging in from Azure AD. "
}

variable "ad_admin_tenant_id" {
  description = "Id to the Azure AD tenant used for SSO. "
}

variable "ad_admin_object_id" {
  description = "Id to the user whom should be admin."
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = "map"

  default = {}
}

variable "release" {
  default     = ""
  description = "The release the deploy is based on."
}
