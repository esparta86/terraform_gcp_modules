variable "project_id" {
  type        = string
  description = "gcp project id"
}

variable "name" {
  type        = string
  description = "name of vpc"
}

variable "routing_mode_vpc" {
  type        = string
  description = "dynamic routing mode that determines how routes learned from Cloud Routers are applied within the network, with options for Regional or Global routing"
}

variable "gcp_cidr_subnet" {
  type        = string
  description = "CIDR range for the subnet"
}

variable "cidr_k8s_pods" {
  type        = string
  description = "CIDR range for the k8s pods"
}

variable "cidr_k8s_services" {
  type        = string
  description = "CIDR range for the k8s services"
}

variable "custom_tags" {
  type        = map(string)
  description = "Custom tags to be applied to the resources"
  default     = {}
}


variable "gcp_cidr_vpc_connector" {
  type        = string
  description = "CIDR range for the VPC connector"
}

variable "enable_vpc_connector" {
  type        = bool
  description = "Enable VPC connector for Cloud Functions"
  default     = false 
}
