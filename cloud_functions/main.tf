

resource "google_storage_bucket" "bucket" {
  name     = "${var.bucket_name_cloud_function}"
  location = "US"
}

data "archive_file" "source_fns" {
  count = length(var.cloud_fn_map)
  type = "zip"
  source_dir = var.cloud_fn_map[count.index].source_dir
  output_path = ".tmp/${var.cloud_fn_map[count.index].name}.zip"
  output_file_mode = "0666"   
}

resource "google_storage_bucket_object" "archives" {
    count = length(var.cloud_fn_map)
    content_type = "application/zip"
    source = element(data.archive_file.source_fns.*.output_path, count.index)
    name = "src-${element(data.archive_file.source_fns.*.output_md5, count.index)}"
    bucket = google_storage_bucket.bucket.name
}

resource "google_cloudfunctions_function" "fns_to_deploy" {
  count = length(var.cloud_fn_map)

  name = "${lookup(element(var.cloud_fn_map,count.index),"name")}"
  runtime = "${lookup(element(var.cloud_fn_map,count.index),"runtime")}"
  entry_point = lookup(element(var.cloud_fn_map,count.index),"entrypoint")
  trigger_http = lookup(element(var.cloud_fn_map,count.index),"trigger_http",false)
  ingress_settings = lookup(element(var.cloud_fn_map,count.index),"ingress_settings","ALLOW_ALL")

#   available_memory_mb = lookup(element(var.cloud_fn_map,count.index),"available_memory_mb",var.default_memory_fn)
#   min_instances  = lookup(element(var.cloud_fn_map,count.index),"min_instances",var.default_min_instances)
#   max_instances  = lookup(element(var.cloud_fn_map,count.index),"max_instances",var.default_max_instances)

  timeout  = lookup(element(var.cloud_fn_map,count.index),"timeout",60)

  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = element(google_storage_bucket_object.archives.*.name,count.index)


  service_account_email = lookup(element(var.cloud_fn_map,count.index),"service_account")

  environment_variables = (lookup(element(var.cloud_fn_map,count.index),"variablesInject","true")  == "true" ? {
    GCLOUD_PROJECT = var.project_id
  } : {

  })

#   labels = merge(var.default_tags_cloud, {
#     "environment" = "${terraform.workspace}"
#   })

  region = var.region

  project = var.project_id
  vpc_connector = "projects/${var.project_id}/locations/${var.region}/connectors/${var.vpc_connector_name}"
  vpc_connector_egress_settings = "PRIVATE_RANGES_ONLY"

}
