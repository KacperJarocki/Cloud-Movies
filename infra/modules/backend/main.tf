resource "azurerm_storage_account" "tf_storage" {
  name                     = "${var.project}${var.env}tfstate"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tf_storage.name
  container_access_type = "private"
}
