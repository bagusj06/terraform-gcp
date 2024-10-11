resource "google_compute_router" "nat_router" {
    name    = local.nat_router_name
    region  = var.region
    network = google_compute_network.vpc.name

    bgp {
        asn = 64514
    }
}

resource "google_compute_router_nat" "nat" {
    name                               = local.nat_name
    router                             = google_compute_router.nat_router.name
    region                             = var.region
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    
    log_config {
        enable = true
        filter = "ERRORS_ONLY"
    }
}