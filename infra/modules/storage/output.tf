output "storage_name" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_primary_access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
}
output "cosmos_db_connection_string" {
  value = azurerm_cosmosdb_account.cosmos.connection_strings[0]
}
