# Creates the GKE cluster
resource "google_container_cluster" "gke" {
  name                        = var.cluster_name
  location                    = var.region
  min_master_version          = var.min_k8s_master_version
  enable_intranode_visibility = false

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.

  remove_default_node_pool = true
  initial_node_count       = 1

  # Use the default VPC network
  network    = "default"
  subnetwork = "default"

  # Aporeto requirement - Need to enable Network Policy
  network_policy {
    enabled = true
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Configure a Managed Node Pool
resource "google_container_node_pool" "nodes" {
  name       = "${var.cluster_name}-nodepool"
  location   = var.region
  cluster    = google_container_cluster.gke.name
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/compute",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      project = "microsegmentation-lab"
    }

    tags = ["${var.project}-node"]
  }
}