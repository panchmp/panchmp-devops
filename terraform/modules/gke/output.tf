output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "kubernetes_cluster_cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}
