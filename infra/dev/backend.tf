terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "cloudmoviestfstate"
    container_name       = "tfstatedev"
    key                  = "terraform.tfstate"
  }
}
