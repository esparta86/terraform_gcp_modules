output "vpc_connector_name" {
  value = google_vpc_access_connector.functions_connector.name
}

output "vpc_connector_id" {
  value = google_vpc_access_connector.functions_connector.id
}

output "vpc_id" {
  value = google_compute_network.vpc_network_gke.id
}

output "sunet_id" {
  value = google_compute_subnetwork.name.id
}

