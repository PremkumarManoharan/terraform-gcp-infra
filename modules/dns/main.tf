data "google_dns_managed_zone" "dns_zone" {
  name = var.dns_zone_name
}

resource "google_dns_record_set" "a" {
  name         = var.domain_name
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  type         = var.record_type
  ttl          = var.record_ttl
  rrdatas      = var.record_rrdatas
}
