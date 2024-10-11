resource "google_compute_firewall" "allow_firewall_rule" {
  for_each = { for rule in var.allow_firewall_rules : rule.name => rule }

  project = var.project_id
  name    = each.value.name
  network = var.network_self_link

  dynamic "allow" {
    for_each = each.value.rule == "allow" ? [1] : []
    content {
      protocol = each.value.protocol
      // Check if port is "all" or empty, then set ports accordingly.
      // Assume each.value.port is a single value or a comma-separated string for multiple ports.
      ports    = each.value.protocol != "icmp" && each.value.port != "all" && each.value.port != "" ? split(",", each.value.port) : []
    }
  }

  // Directly use each.value.source_ip if it's already a list.
  source_ranges = each.value.source_ip
  direction     = "INGRESS"
}



resource "google_compute_firewall" "deny_firewall_rule" {
  for_each = { for rule in var.deny_firewall_rules : rule.name => rule }

  project = var.project_id
  name    = each.value.name
  network = var.network_self_link

  dynamic "deny" {
    for_each = each.value.rule == "deny" ? [1] : []
    content {
      protocol = each.value.protocol
      // Ensure ports are handled correctly; split if comma-separated
      ports    = each.value.protocol != "icmp" && each.value.port != "all" && each.value.port != "" ? split(",", each.value.port) : []
    }
  }

  // Assuming each.value.source_ip is already correctly formatted as a list
  source_ranges = each.value.source_ip
  direction     = "INGRESS"
}
