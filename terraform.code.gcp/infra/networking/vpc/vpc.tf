resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = local.vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "vpc" {
  name          = local.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc.id
}