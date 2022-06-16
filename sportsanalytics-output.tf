output "AKV" {
  value = azurerm_key_vault.SportsAnalyticsAKV
  sensitive = true
}

output "AzureEventHub" {
  value = azurerm_eventhub_namespace.SportsAnalyticsEventHub
  sensitive = true
}

output "AzureDatabricks" {
  value = azurerm_eventhub_namespace.SportsAnalyticsEventHub
  sensitive = true
}

output "AzureDatafactory" {
  value = azurerm_data_factory.adf
  sensitive = true
}

output "AzureDatalakeStorage" {
  value = azurerm_storage_account.SportsAnalyticsADLS
  sensitive = true
}

output "azuredatafactoryMI" {
  value = azurerm_role_assignment.adf_MI
  sensitive = true
}