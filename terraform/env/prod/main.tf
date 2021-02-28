terraform {
  required_version = ">= 0.14"
}

module "vpc" {
  source = "../../modules/vpc"
  project_id = var.project_id
  region = var.region
}

module "gke" {
  source = "../../modules/gke"

  project_id = var.project_id
  //location = var.region
  location = var.zone

  network_name = module.vpc.network_name
  subnetwork_name = module.vpc.subnetwork_name

  node_pool = var.node_pool
}

module "k8s" {
  source = "../../modules/k8s"

  project_id = var.project_id
  region = var.region

  depends_on = [
    module.gke
  ]
}
