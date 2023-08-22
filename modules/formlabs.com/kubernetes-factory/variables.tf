variable "cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "project_id" {
  type        = string
  description = "The ID of a project to host this cluster"
}

variable "cluster_region" {
  type        = string
  description = "The region to host the cluster in"
  default     = "us-east1"
}

variable "cluster_zones" {
  type        = list(string)
  description = "The zones to host the cluster in"
  default     = ["us-east1-b", "us-east1-c"]
}

variable "machine_types" {
  type        = list(string)
  description = "The list of machine types"
  default     = ["e2-standard-4"]
}

variable "cluster_min_node" {
  type        = number
  description = "Minimum number of nodes in NodePool"
  default     = 0
}

variable "cluster_max_node" {
  type        = string
  description = "Maximum number of nodes in NodePool"
  default     = 5
}

variable "disk_size_gb" {
  type        = number
  description = "Size of the disk attached to each node, specified in GB"
  default     = 100
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version of the masters"
}

variable "subnet" {
  type        = string
  description = "The subnet being created"
  default     = "10.0.0.0/22"
}

variable "pods_range" {
  type        = string
  description = "Secondary range will be used in pod networking"
  default     = "172.16.0.0/20"
}

variable "services_range" {
  type        = string
  description = "Secondary range will be used in service networking"
  default     = "172.16.128.0/20"
}

variable "labels" {
  type        = map(string)
  description = "The list of labels that assign with the project"
  default     = {}
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks"
  default     = []
}
