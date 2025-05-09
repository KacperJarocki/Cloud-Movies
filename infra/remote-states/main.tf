module "backend" {
  source   = "../modules/backend"
  rg_name  = "tfstate"
  location = "westeurope"
  project  = "cloudmoviess"
  envs     = ["dev", "prod"]
}

