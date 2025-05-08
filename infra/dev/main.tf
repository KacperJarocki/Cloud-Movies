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
