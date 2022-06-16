provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

#Azure Resource Group
resource "azurerm_resource_group" "SportsAnalyticsRG" {
  name     = var.SportsAnalyticsRG
  location = var.SportsAnalyticsRGRegion

  tags = { environment = "SportsAnalytics-Demo" }
}

#Azure Key Vault
resource "azurerm_key_vault" "SportsAnalyticsAKV" {
  name                = var.AzureKeyVaultName
  location            = azurerm_resource_group.SportsAnalyticsRG.location
  resource_group_name = azurerm_resource_group.SportsAnalyticsRG.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.AzureKeyVaultSku
  tags                = { environment = "SportsAnalytics-Demo" }
}

#Azure Event Hub
resource "azurerm_eventhub_namespace" "SportsAnalyticsEventHub" {
  name                = var.SportsAnalyticsEventHubName
  location            = azurerm_resource_group.SportsAnalyticsRG.location
  resource_group_name = azurerm_resource_group.SportsAnalyticsRG.name
  sku                 = var.SportsAnalyticsEventSku
  capacity            = var.SportsAnalyticsEventHubCapacity
  tags                = { environment = "SportsAnalytics-Demo" }
}

#Azure Databricks
resource "azurerm_databricks_workspace" "SportsAnalyticsADB" {
  name                = var.SportsAnalyticsADBname
  resource_group_name = azurerm_resource_group.SportsAnalyticsRG.name
  location            = azurerm_resource_group.SportsAnalyticsRG.location
  sku                 = var.SportsAnalyticsADBSku
  tags                = { environment = "SportsAnalytics-Demo" }
}

#Azure Datafactory
resource "azurerm_data_factory" "adf" {
  name                = var.SportsAnalyticsADF
  resource_group_name = azurerm_resource_group.SportsAnalyticsRG.name
  location            = azurerm_resource_group.SportsAnalyticsRG.location
  identity {
    type = "SystemAssigned"
  }
  tags = { environment = "SportsAnalytics-Demo" }
}

#Azure Datalake Storage
resource "azurerm_storage_account" "SportsAnalyticsADLS" {
  name                     = var.SportsAnalyticsADLSName
  resource_group_name      = azurerm_resource_group.SportsAnalyticsRG.name
  location                 = azurerm_resource_group.SportsAnalyticsRG.location
  account_tier             = var.SportsAnalyticsADLSAccountTier
  account_replication_type = var.SportsAnalyticsADLSReplicationType
  account_kind             = var.SportsAnalyticsADLSAccountKind
  is_hns_enabled           = var.enable
  tags                     = { environment = "SportsAnalytics-Demo" }
}

#Azure Datafactory MI
resource "azurerm_role_assignment" "adf_MI" {
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.SportsAnalyticsADLS.id
  principal_id         = azurerm_data_factory.adf.identity[0].principal_id
}

#Azure Key Vault Access Policy
resource "azurerm_key_vault_access_policy" "adf_access" {
  key_vault_id       = azurerm_key_vault.SportsAnalyticsAKV.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_data_factory.adf.identity[0].principal_id
  key_permissions    = ["Get", "List"]
  secret_permissions = ["Get", "List"]
  lifecycle {
    prevent_destroy = false #While true this prevents Terraform Destroy? 
  }
}

#Azure Datafactory self hosted integration runtime
resource "azurerm_data_factory_integration_runtime_self_hosted" "sh_ir" {
  name            = var.SportsAnalyticsSH_IR
  data_factory_id = azurerm_data_factory.adf.id
}

#Azure Datafactory Linked Service - Key Vault
resource "azurerm_data_factory_linked_service_key_vault" "akv_ls" {
  name            = var.SportsAnalyticsAKV_LS
  data_factory_id = azurerm_data_factory.adf.id
  key_vault_id    = azurerm_key_vault.SportsAnalyticsAKV.id
}

#Azure Data Factory Linked Service - Data Lake Storage
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "adls_ls" {
  name                 = var.SportsAnalyticsADLSLS
  data_factory_id      = azurerm_data_factory.adf.id
  use_managed_identity = true
  url                  = azurerm_storage_account.SportsAnalyticsADLS.primary_dfs_endpoint
}