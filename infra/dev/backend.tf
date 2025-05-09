terraform {
  backend "azurerm" {
    resource_group_name  = "cloudmovies-dev-rg"
    storage_account_name = "cloudmoviesdevtfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
