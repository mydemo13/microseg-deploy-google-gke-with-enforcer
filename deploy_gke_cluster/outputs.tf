output "get_kubeconfig_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.gke.name} --region ${google_container_cluster.gke.location} --project ${google_container_cluster.gke.project}"
}