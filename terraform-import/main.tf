data "google_compute_network" "default" {
  name = "default"
}

data "google_container_cluster" "existing" {
  name     = "cluster-1"
  location = "us-central1-a"
}

# If you want to manage the cluster resource later, prefer managing node pools separately.
# For now we ignore fields that would force a replacement when importing an existing cluster.
resource "google_container_cluster" "existing" {
  name     = "cluster-1"
  location = "us-central1-a"
  network  = data.google_compute_network.default.name

  lifecycle {
    ignore_changes = [
      initial_node_count,
      node_pool,
      node_config,
      ip_allocation_policy,
      network,
      remove_default_node_pool,
    ]
  }
}

output "gke_cluster_name" {
  value = data.google_container_cluster.existing.name
}

output "gke_cluster_network" {
  value = data.google_container_cluster.existing.network
}

output "gke_cluster_location" {
  value = data.google_container_cluster.existing.location
}
