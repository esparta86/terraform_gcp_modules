output "vpc_connector_name" {
  value = try(google_vpc_access_connector.functions_connector[0].name,"")
}

output "vpc_connector_id" {
  value = try(google_vpc_access_connector.functions_connector[0].id,"")
}

output "vpc_id" {
  value = google_compute_network.vpc_network_gke.id
}

output "sunet_id" {
  value = google_compute_subnetwork.name.id
}

