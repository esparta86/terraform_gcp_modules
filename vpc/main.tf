resource "google_compute_network" "vpc_network_gke" {
  project                 = var.project_id
  name                    = "vpc-${var.name}"
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode_vpc
}


resource "google_compute_subnetwork" "name" {
  name = "sunet-${var.name}"
  ip_cidr_range = var.gcp_cidr_subnet
  network = google_compute_network.vpc_network_gke.id
  project = var.project_id
  region = "us-east1"
  private_ip_google_access = true # Allow private access to Google APIs

  secondary_ip_range {
    range_name    = "k8s-pods"
    ip_cidr_range = var.cidr_k8s_pods
  }
  secondary_ip_range {
    range_name    = "k8s-services"
    ip_cidr_range = var.cidr_k8s_services
  }
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }

  depends_on = [google_compute_network.vpc_network_gke]
  }
