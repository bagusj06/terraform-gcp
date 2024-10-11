output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "network_id" {
  description = "VPC ID"
  value       = google_compute_network.vpc.id
}

output "subnet_name"{
  description = "The name of subnet"
  value       = google_compute_subnetwork.vpc.name
}

output "vpc_primary_ip_cidr_range" {
    description = "The primary IP CIDR range of the VPC"
    value       = google_compute_subnetwork.vpc.ip_cidr_range
}

output "network_self_link" {
  value = google_compute_network.vpc.self_link
}
