variable "resource_group_name" {
  type    = string
  default = "k8s-rg"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "cluster_name" {
  type    = string
  default = "k8s-cluster"
}

variable "dns_prefix" {
  type    = string
  default = "k8scluster"
}

# System pool
variable "system_node_count" {
  type    = number
  default = 1
}

variable "system_vm_size" {
  type    = string
  default = "Standard_B2s"
}

# Worker pool
variable "worker_count" {
  type    = number
  default = 2
}

variable "worker_vm_size" {
  type    = string
  default = "Standard_B2s"
}

