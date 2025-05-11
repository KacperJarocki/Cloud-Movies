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


