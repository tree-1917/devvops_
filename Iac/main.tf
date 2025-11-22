terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.74.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -------------------------
# Resource Group
# -------------------------
resource "azurerm_resource_group" "k8s_rg" {
  name     = var.resource_group_name
  location = var.location
}

# -------------------------
# AKS Cluster
# -------------------------
resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.k8s_rg.name
  dns_prefix          = var.dns_prefix

  # System Node Pool (acts like master)
  default_node_pool {
    name       = "system"
    node_count = var.system_node_count
    vm_size    = var.system_vm_size
  }

  identity {
    type = "SystemAssigned"
  }
}

# -------------------------
# Worker Node Pool
# -------------------------
resource "azurerm_kubernetes_cluster_node_pool" "worker_pool" {
  name                  = "worker"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s_cluster.id
  vm_size               = var.worker_vm_size
  node_count            = var.worker_count
  mode                  = "User"
  os_type               = "Linux"
}

# -------------------------
# Save kubeconfig to file
# -------------------------
resource "local_file" "kubeconfig" {
  content  = azurerm_kubernetes_cluster.k8s_cluster.kube_config_raw
  filename = "kubeconfig_${var.cluster_name}"
}

