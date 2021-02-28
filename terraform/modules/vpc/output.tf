output "network_name" {
  value = google_compute_network.vpc.name
  description = "GKE Network Name"
}

output "network_id" {
  value = google_compute_network.vpc.id
  description = "GKE Network Name"
}

output "subnetwork_name" {
  value = google_compute_subnetwork.subnet.name
  description = "GKE Subnetwork Name"
}