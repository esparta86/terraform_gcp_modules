variable "bucket_name_cloud_function" {
  type        = string
  description = "Name of the Cloud Function storage bucket" 
}

variable "cloud_fn_map" {
  type        = list(map(any))
  description = "List of cloud functions with their properties"
}
