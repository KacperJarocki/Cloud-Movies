
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

module "compute" {
  source                      = "../modules/compute"
  rg_name                     = module.network.rg_name
  location                    = var.location
  env                         = var.env
  project                     = var.project
  storage_name                = module.storage.storage_name
  storage_primary_access_key  = module.storage.storage_primary_access_key
  subnet_id                   = module.network.subnet_id
  instrumentation_key_insight = module.monitoring.instrumentation_key
  connection_string_insight   = module.monitoring.connection_string
}
