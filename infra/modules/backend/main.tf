resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}
resource "azurerm_storage_account" "tf_storage" {
  name                     = "${var.project}tfstate"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  for_each              = toset(var.envs)
  name                  = "tfstate${each.key}"
  storage_account_name  = azurerm_storage_account.tf_storage.name
  container_access_type = "private"
}
