resource "azurerm_app_service_plan" "service_plan" {
  name                = "${var.project}-${var.env}-appserviceplan"
  location            = var.location
  resource_group_name = var.rg_name
  kind                = "FunctionApp"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "${var.project}-${var.env}-app-service"
  location            = var.location
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.instrumentation_key_insight
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.connection_string_insight
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_function_app" "function_app" {
  name                       = "${var.project}-${var.env}-azure-functions"
  location                   = var.location
  resource_group_name        = var.rg_name
  app_service_plan_id        = azurerm_app_service_plan.service_plan.id
  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_primary_access_key
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.instrumentation_key_insight
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.connection_string_insight
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "COSMOSDB_CONNECTION_STRING"                 = var.cosmos_db_connection_string
  }
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_app_service_virtual_network_swift_connection" "app_service_connection" {
  app_service_id = azurerm_app_service.app_service.id
  subnet_id      = var.subnet_id
}
resource "azurerm_app_service_virtual_network_swift_connection" "app_function_connection" {
  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.subnet_id
}
