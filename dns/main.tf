
module "public_dns" {
  source = "GoogleCloudPlatform/cloud-foundation-fabric//modules/dns"
  version = "v38.1.0"

    project_id = var.project_id
    name       = var.dns_name

    zone_config = {
      domain = var.dns_domain
    }


}
