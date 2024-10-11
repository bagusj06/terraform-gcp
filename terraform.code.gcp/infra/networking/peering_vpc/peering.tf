resource "google_compute_network_peering" "vpc_peering" {
  # Use a for_each loop to iterate over each peering config item
  for_each = { for cfg in var.peering_configs : "${cfg.peer_vpc_name}-${cfg.peer_project_id}" => cfg }

  # Construct a peering name from each peering configuration
  name         = "peering-${each.value.peer_vpc_name}-${each.value.peer_project_id}"
  
  # Use the network self link provided as a variable
  network      = var.network_self_link

  export_custom_routes = true
  import_custom_routes = true
  
  # Construct the peer network self link dynamically
  peer_network = "https://www.googleapis.com/compute/v1/projects/${each.value.peer_project_id}/global/networks/${each.value.peer_vpc_name}"
}