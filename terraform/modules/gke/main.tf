# GKE cluster
resource "google_container_cluster" "primary" {
  provider = google-beta

  name = "${var.project_id}-gke"
  location = var.location

  remove_default_node_pool = true
  initial_node_count = 1

  ip_allocation_policy {
    cluster_ipv4_cidr_block = var.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = true
    }
    dns_cache_config {
      enabled = true
    }
  }

  network = var.network_name
  subnetwork = var.subnetwork_name

  master_auth {
    username = var.gke_username
    password = var.gke_password

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  release_channel {
    channel = "STABLE"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "05:00"
    }
  }
}

resource "google_container_node_pool" "node_pool" {
  for_each = var.node_pool

  name = each.key
  location = google_container_cluster.primary.location
  cluster = google_container_cluster.primary.name

  node_config {
    preemptible = each.value.preemptible
    machine_type = each.value.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  initial_node_count = each.value.min_node_count

  autoscaling {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }
}