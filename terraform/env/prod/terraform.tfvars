project_id = "location-306206"
region = "us-east1"
zone = "us-east1-b"

node_pool = {
  preemptible-nodes = {
    machine_type = "n1-standard-1"
    preemptible = true
    min_node_count = 1
    max_node_count = 4
  },
  main-nodes = {
    machine_type = "n1-standard-1"
    preemptible = false
    min_node_count = 0
    max_node_count = 3
  }
}
