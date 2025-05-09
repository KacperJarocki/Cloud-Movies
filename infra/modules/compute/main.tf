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
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

resource "azurerm_function_app" "function_app" {
  name                       = "${var.project}-${var.env}-azure-functions"
  location                   = var.location
  resource_group_name        = var.rg_name
  app_service_plan_id        = azurerm_app_service_plan.service_plan.id
  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_primary_access_key
}
resource "azurerm_app_service_virtual_network_swift_connection" "app_service_connection" {
  app_service_id = azurerm_app_service.app_service.id
  subnet_id      = var.subnet_id
}
resource "azurerm_app_service_virtual_network_swift_connection" "app_function_connection" {
  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.subnet_id
}
