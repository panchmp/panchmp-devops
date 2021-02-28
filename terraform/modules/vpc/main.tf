# Subnet
resource "google_compute_subnetwork" "subnet" {
  name = "${var.project_id}-subnet"

  ip_cidr_range = var.subnet_cidr

  private_ip_google_access = true
  //region = var.region
  network = google_compute_network.vpc.id
}

# VPC
resource "google_compute_network" "vpc" {
  name = "${var.project_id}-vpc"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}