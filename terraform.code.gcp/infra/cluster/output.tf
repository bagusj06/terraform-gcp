output "cluster_name" {
  description = "Cluster Name"
  value       = google_container_cluster.private_cluster.name
}

output "authorized_networks" {
  description = "Auth Networks"
  value       = google_container_cluster.private_cluster.master_authorized_networks_config
}

output "ip_allocation_policy" {
  description = "IP allocation"
  value       = google_container_cluster.private_cluster.ip_allocation_policy
}

output "service_ip" {
  description = "Service IP"
  value       = google_container_cluster.private_cluster.private_cluster_config
}

output "release_channel" {
  description = "Release channel"
  value       = google_container_cluster.private_cluster.release_channel
}