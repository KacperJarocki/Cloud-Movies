resource "azurerm_application_insights" "app_insights" {
  name                = "${var.project}-${var.env}-appinsights"
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = "web"
}
