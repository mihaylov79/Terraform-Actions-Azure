terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.38.1"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location

}

resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = var.os_type
  sku_name            = var.sku_name

}

resource "azurerm_mssql_server" "DBserver" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password

}

resource "azurerm_mssql_firewall_rule" "rule" {
  name             = var.sql_server_name
  server_id        = azurerm_mssql_server.DBserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "db" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.DBserver.id
  collation      = var.db_colation
  license_type   = var.db_licence_type
  sku_name       = var.db_sku_name
  zone_redundant = false

}

resource "azurerm_linux_web_app" "alwa" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }

  }
  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.DBserver.name}.database.windows.net,1433;Initial Catalog=${azurerm_mssql_database.db.name};User ID=${azurerm_mssql_server.DBserver.administrator_login};Password=${var.sql_admin_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }


}

resource "azurerm_app_service_source_control" "ascr" {
  app_id                 = azurerm_linux_web_app.alwa.id
  repo_url               = var.repo_URL
  branch                 = "main"
  use_manual_integration = true
}