

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

