output "storage_name" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_primary_access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
}
