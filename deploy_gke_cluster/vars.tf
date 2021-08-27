variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster"
}

variable "min_k8s_master_version" {
  default     = "1.20"
  type        = string
  description = "The minimum version of Kubernetes"
}

variable "node_count" {
  default     = 1
  type        = number
  description = "The nmber of nodes per AZ in the kubernetes cluster"
}

variable "machine_type" {
  type        = string
  description = "The GCP Machine Type"
}
