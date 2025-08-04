variable "resource_group_name" {
  type        = string
  description = "Resource group name in Azure"
}

variable "resource_group_location" {
  type        = string
  description = "Location"

}

variable "app_service_plan_name" {
  type = string

}

variable "app_service_name" {
  type        = string
  description = "Application service name"
}

variable "sql_server_name" {
  type        = string
  description = "SQL Server name"
}

variable "sql_database_name" {
  type        = string
  description = "Database name"
}

variable "sql_admin_login" {
  type        = string
  description = "Admin login"

}
variable "sql_admin_password" {
  type        = string
  description = "Admin pasword"

}

variable "firewall_rule_name" {
  type = string
}

variable "repo_URL" {
  type        = string
  description = "The URL of the used repo"
}

variable "os_type" {
  type        = string
  description = "app_service_plan OS type"
  default     = "Linux"

}

variable "sku_name" {
  type        = string
  description = "Subscription type"
  default     = "B1"

}

# variable "applicatiоn_stack" {
#   type = string
# }

variable "db_colation" {
  type    = string
  default = "Cyrillic_General_CI_AS"

}

variable "db_licence_type" {

  type    = string
  default = "LicenseIncluded"

}

variable "db_sku_name" {
  type    = string
  default = "Basic"

}

variable "subscription_id" {
  type        = string
  description = "User subscription id"

}

variable "tenant_id" {
  type        = string
  description = "User tenant id"

}
