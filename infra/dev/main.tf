module "network" {
  source   = "../modules/network"
  project  = var.project
  env      = var.env
  location = var.location
}
