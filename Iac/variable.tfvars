resource_group_name = "k8s-rg"
location            = "eastus"
cluster_name        = "k8s-cluster"
dns_prefix          = "devops"

system_node_count = 1
system_vm_size    = "Standard_B2s"

worker_count    = 2
worker_vm_size  = "Standard_B2s"

