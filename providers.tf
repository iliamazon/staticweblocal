terraform {
  required_version = ">=1.0"

  

  required_providers {
    backend "azurerm" {
      resource_group_name  = "rgtf"
      storage_account_name = "tfstatesa"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  skip_provider_registration = true
}