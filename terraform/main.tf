provider "google" {
  project = "hospital-project-485718"
  region  = "us-central1-a"
}

# This matches your imported cluster
resource "google_container_cluster" "my_cluster" {
  name     = "cluster-1"
  location = "us-central1-a"
}

# Outputs for pipeline
output "cluster_name" {
  value = google_container_cluster.my_cluster.name
}

output "cluster_endpoint" {
  value = google_container_cluster.my_cluster.endpoint
}

# Node pool info instead of node_count
output "default_node_pool_count" {
  value = google_container_cluster.my_cluster.node_pool[0].initial_node_count
}
