variable "bucket_name_cloud_function" {
  type        = string
  description = "Name of the Cloud Function storage bucket" 
}

variable "cloud_fn_map" {
  type        = list(map(any))
  description = "List of cloud functions with their properties"
}

variable "project_id" {
  type = string
  description = "The GCP project ID where the Cloud Functions will be deployed"
}

variable "region" {
  type        = string
  description = "The region where the Cloud Functions will be deployed"
}
