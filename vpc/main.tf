resource "google_compute_network" "vpc_network_gke" {
  project                 = var.project_id
  name                    = var.name
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode_vpc
  delete_default_routes_on_create = true
}
