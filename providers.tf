terraform {

  required_providers {
    #random = {
    #  source  = "hashicorp/random"
    #}

    azurerm ={
    #  source ="haschicorp/azurerm"
      version = "~>3.95.0"    
    }

  }

}

provider "azurerm" {
  features {}


  # subscription_id            = var.subscription_id
  # client_id                  = var.client_id
  # client_secret              = var.client_secret
  # tenant_id                  = var.tenant_id
  skip_provider_registration = true
}