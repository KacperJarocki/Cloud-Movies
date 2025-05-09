module "backend" {
  source   = "../modules/backend"
  rg_name  = "tfstate"
  location = "westeurope"
  project  = "cloudmovies"
  envs     = ["dev", "prod"]
}

