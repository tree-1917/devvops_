output "cluster_name" {
  value = azurerm_kubernetes_cluster.k8s_cluster.name
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.k8s_cluster.kube_config_raw
  sensitive = true
}

