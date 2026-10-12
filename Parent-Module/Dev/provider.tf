terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "ut-backup-rg"
    storage_account_name = "backupstg007"  # <- use module output
    container_name       = "aod-storage"
    key                  = "dev/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

#now backend get added
