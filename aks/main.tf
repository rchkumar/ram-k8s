terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.26.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "learnk8srg" {
  name     = "learnk8sResourceGroup"
  location = "southindia"
}


resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "learnk8scluster"
  location            = azurerm_resource_group.learnk8srg.location
  resource_group_name = azurerm_resource_group.learnk8srg.name
  dns_prefix          = "learnk8scluster"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [

    azurerm_resource_group.learnk8srg
  ]
}