#Some of the default values are case sensitive
#You will have to pick a global unique name for your Azure Datalake Storage Account. Default value may be taken. 

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "current" {}

#Variables for Azure Resource Group
variable "SportsAnalyticsRG" {
  description = "Resource Group name"
  type        = string
  default     = "SportsAnalyticsRG"
}

#Variables for Azure Resource Group
variable "SportsAnalyticsRGRegion" {
  description = "Resource Group Region"
  type        = string
  default     = "eastus"
}

#Variables for Azure Key Vault
variable "AzureKeyVaultName" {
  description = "Secret Management"
  type        = string
  default     = "SportsAnalyticsAKV"
}

#Variables for Azure Key Vault Sku Size
variable "AzureKeyVaultSku" {
  description = "Azure Key Vault Sku Size"
  type        = string
  default     = "standard"
}

#Variable for Azure Event Hub - Name
variable "SportsAnalyticsEventHubName" {
  description = "Event Hub Name"
  type        = string
  default     = "SportsAnalyticsEventHub"
}

#Variable for Azure Event Hub - Sku
variable "SportsAnalyticsEventSku" {
  description = "Event Hub Sku Size"
  type        = string
  default     = "Standard"
}

#Variable for Azure Event Hub - Count
variable "SportsAnalyticsEventHubCapacity" {
  description = "Event Hub Capacity"
  type        = number
  default     = 1
}

#Variables for Azure Databricks
variable "SportsAnalyticsADBname" {
  description = "Azure Databricks"
  type        = string
  default     = "SportsAnalyticsADB"
}

#Variables for Azure Databricks Sku Size
variable "SportsAnalyticsADBSku" {
  description = "Azure Databricks Sku Size"
  type        = string
  default     = "premium"
}

#Variables for Azure Data Factory
variable "SportsAnalyticsADF" {
  description = "Azure Datafactory"
  type        = string
  default     = "SportsAnalyticsADF"
}

#Variables for Azure Storage Datalake Storage Name
variable "SportsAnalyticsADLSName" {
  description = "Azure DataLake Storage Name"
  type        = string
  default     = "sportsanalyticsadl"
}

#Variables for Azure Storage Datalake Storage Tier
variable "SportsAnalyticsADLSAccountTier" {
  description = "Azure DataLake Storage"
  type        = string
  default     = "Standard"
}

#Variables for Azure Storage Datalake Storage Replication Type
variable "SportsAnalyticsADLSReplicationType" {
  description = "Azure DataLake Storage"
  type        = string
  default     = "LRS"
}

#Variable for Azure Storage Datalake Storage Kind
variable "SportsAnalyticsADLSAccountKind" {
  description = "Azure DataLake Storage"
  type        = string
  default     = "StorageV2"
}

#Variable for Azure Datalake Storage enable 
variable "enable" {
  description = "enable storage account ADLS"
  type        = bool
  default     = true
}

#Variable for Azure Datafactory Self Hosted Integration Runtime
variable "SportsAnalyticsSH_IR" {
  description = "Azure Datafactory Self Hosted Integration Runtime"
  type        = string
  default     = "SportsAnalyticsSHIR"
}

#Variable for Azure Key Vault Link
variable "SportsAnalyticsAKV_LS" {
  description = "Azure Key Vault Link"
  type        = string
  default     = "SportsAnalyticsAKVLS"
}

#Azure Data Factory Linked Service to Data Lake
variable "SportsAnalyticsADLSLS" {
  description = "Azure DataLake LS"
  type        = string
  default     = "SportsAnalyticsADLSLS"
}