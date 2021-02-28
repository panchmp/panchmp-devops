variable "project_id" {
  description = "project id"
}

variable "location" {
  description = "location"
}

variable "gke_username" {
  default = ""
  description = "gke username"
}

variable "gke_password" {
  default = ""
  description = "gke password"
}

variable "network_name" {}

variable "subnetwork_name" {}

variable "cluster_ipv4_cidr_block" {
  type = string
  default = "10.20.0.0/16"
}

variable "services_ipv4_cidr_block" {
  type = string
  default = "10.30.0.0/16"
}

variable "node_pool" {
  type = map(object({
    machine_type = string
    preemptible = bool
    min_node_count = number
    max_node_count = number
  }))
}