module "network" {
  source   = "../modules/network"
  project  = var.project
  env      = var.env
  location = var.location
}

module "storage" {
  source   = "../modules/storage"
  rg_name  = module.network.rg_name
  location = var.location
  env      = var.env
  project  = var.project
}

module "monitoring" {
  source   = "../modules/monitoring"
  rg_name  = module.network.rg_name
  location = var.location
  env      = var.env
  project  = var.project
}

module "keyvault" {
  source              = "../modules/keyvault"
  name_prefix         = "${var.project}-${var.env}"
  location            = var.location
  resource_group_name = module.network.rg_name
  tags                = { environment = var.env }

  secrets = {
    "CosmosDbConnection"            = module.storage.cosmos_db_connection_string
    "AppInsightsInstrumentationKey" = module.monitoring.instrumentation_key
    "AppInsightsConnectionString"   = module.monitoring.connection_string
  }
}


data "azurerm_key_vault" "kv" {
  name                = "${var.project}-${var.env}-kv"
  resource_group_name = module.network.rg_name
}

data "azurerm_key_vault_secret" "cosmos_db_connection" {
  name         = "CosmosDbConnection"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sql_db_connection" {
  name         = "SqlDbConnection"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "insights_key" {
  name         = "AppInsightsInstrumentationKey"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "insights_connection" {
  name         = "AppInsightsConnectionString"
  key_vault_id = data.azurerm_key_vault.kv.id
}
module "compute" {
  source                      = "../modules/compute"
  rg_name                     = module.network.rg_name
  location                    = var.location
  env                         = var.env
  project                     = var.project
  storage_name                = module.storage.storage_name
  storage_primary_access_key  = module.storage.storage_primary_access_key
  subnet_id                   = module.network.subnet_id
  instrumentation_key_insight = data.azurerm_key_vault_secret.insights_key.value
  connection_string_insight   = data.azurerm_key_vault_secret.insights_connection.value
  cosmos_db_connection_string = data.azurerm_key_vault_secret.cosmos_db_connection.value
  depends_on                  = [module.keyvault]
}

