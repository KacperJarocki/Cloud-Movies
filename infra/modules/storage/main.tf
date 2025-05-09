resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.project}${var.env}sasw"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
  tags = {
    environment = var.env
  }
}

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "${var.project}-${var.env}-cdn-profile"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard_Microsoft"
  tags = {
    environment = var.env
  }
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "${var.project}-${var.env}-cdn-endpoint"
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  location            = var.location
  resource_group_name = var.rg_name
  is_http_allowed     = true
  is_https_allowed    = true
  origin_host_header  = azurerm_storage_account.storage_account.primary_web_host
  content_types_to_compress = [
    "text/html",
    "text/css",
    "application/javascript",
    "application/json",
  ]
  is_compression_enabled = true

  origin {
    name      = "storageorigin"
    host_name = replace(trim(azurerm_storage_account.storage_account.primary_web_endpoint, "/"), "https://", "")
  }


  tags = {
    environment = var.env
  }
}

resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "${var.project}${var.env}cosmos"
  location            = var.location
  resource_group_name = var.rg_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "${var.project}-${var.env}-db"
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
}
