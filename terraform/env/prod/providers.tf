provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
}

provider "google-beta" {
  project = var.project_id
  region = var.region
  zone = var.zone
}

data "google_client_config" "provider" {}

provider "helm" {
  kubernetes {
    host = "https://${module.gke.kubernetes_cluster_endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(module.gke.kubernetes_cluster_cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host = "https://${module.gke.kubernetes_cluster_endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(module.gke.kubernetes_cluster_cluster_ca_certificate)
}