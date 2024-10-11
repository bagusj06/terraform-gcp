provider "google-beta" {
  region = var.region
  zone   = var.zone
  project = var.project_id
}

resource "google_compute_global_address" "private_ip_address" {
  name          = local.private_ip_name
  purpose       = "VPC_PEERING"
  prefix_length = 20
  address_type  = "INTERNAL"
  network       = var.network_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_compute_global_address.private_ip_address]
}

resource "google_sql_database_instance" "db_dcs" {
  name             = local.db_name
  region           = var.region
  database_version = var.database_version

  deletion_protection = false

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    edition = "ENTERPRISE"
    tier = var.instance_tier
    ip_configuration {
      ipv4_enabled                                  = true
      private_network                               = var.network_id
      enable_private_path_for_google_cloud_services = true

      dynamic "authorized_networks" {
        for_each = var.auth_network
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.ip
        }
      }
    }
  }
}