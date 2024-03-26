resource "google_vpc_access_connector" "connector" {
  name          = var.name
  subnet {
    name = var.subnet 
  }
}
