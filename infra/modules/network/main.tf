resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-${var.env}-rg"
  location = var.location
}
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-${var.env}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}
