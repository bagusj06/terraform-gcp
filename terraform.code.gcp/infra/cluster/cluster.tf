resource "google_container_cluster" "private_cluster" {
  name     = local.cluster_name
  location = var.region
  
  remove_default_node_pool = true
  initial_node_count = 1

  network       = local.vpc_name
  subnetwork    = local.subnet_name

  deletion_protection = var.deletion_protection

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  release_channel {
    channel = var.release_channel
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.auth_network
      content {
        cidr_block   = cidr_blocks.value.ip
        display_name = cidr_blocks.value.name
      }
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block = var.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }

  maintenance_policy {
    recurring_window {
      start_time    = var.maintenance_start_time
      end_time      = var.maintenance_end_time
      recurrence    = var.maintenance_recurrence 
    } 
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = local.pool_name
  location   = var.region
  cluster    = google_container_cluster.private_cluster.name
  node_count = 1
  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = false  # Changed from true to false
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
