output "vpc_peering_details" {
  value = { for peering in google_compute_network_peering.vpc_peering :
    "${peering.name}" => {
      name          = peering.name
      network       = peering.network
      peer_network  = peering.peer_network
      export_routes = peering.export_custom_routes
      import_routes = peering.import_custom_routes
    }
  }
  description = "Details of each VPC peering configuration"
}
