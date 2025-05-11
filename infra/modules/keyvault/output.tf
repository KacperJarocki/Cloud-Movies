output "key_vault_id" {
  value = azurerm_key_vault.this.id
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "secret_uris" {
  value = {
    for key, secret in azurerm_key_vault_secret.secrets :
    key => secret.id
  }
}
