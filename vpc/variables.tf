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
