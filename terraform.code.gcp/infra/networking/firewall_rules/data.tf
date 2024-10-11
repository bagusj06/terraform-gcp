data "google_compute_network" "vpc_network" {
  name = local.vpc_name
}