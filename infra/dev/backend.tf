terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "cloudmoviesstfstate"
    container_name       = "tfstatedev"
    key                  = "terraform.tfstate"
    use_oidc             = true

  }
}
