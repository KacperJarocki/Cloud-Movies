terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "cloudmoviesstfstate"
    container_name       = "tfstateprod"
    key                  = "terraform.tfstate"
  }
}
