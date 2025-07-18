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
  region  = var.region
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


  resource "google_compute_router" "router" {
    name = "router-${var.name}"
    network = google_compute_network.vpc_network_gke.id
    region  = var.region
    project = var.project_id
    bgp {
      asn = 65001
    }
    
  }


  resource "google_compute_router_nat" "nat" {
    name = "nat-${var.name}"
    router = google_compute_router.router.name
    region = var.region
    project = var.project_id
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    min_ports_per_vm = 64
  }


resource "google_vpc_access_connector" "functions_connector" {
  count = var.enable_vpc_connector ? 1 : 0
  max_throughput = var.functionconnector_vpc_ac_max_throughput
  min_throughput = var.functionconnector_vpc_ac_min_throughput
  depends_on = [ google_compute_network.vpc_network_gke ]
  name = "vpcconnector${var.name}"
  region = var.region
  network = google_compute_network.vpc_network_gke.id
  ip_cidr_range = var.gcp_cidr_vpc_connector
  project = var.project_id
  
}
