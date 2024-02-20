module "vpc1" {
  for_each                            = { for s in toset(var.vpcs) : s.vpc_name => s }
  source                              = "./modules/vpc"
  vpc_auto_create_subnetworks         = each.value.vpc_auto_create_subnetworks
  vpc_delete_default_routes_on_create = each.value.vpc_delete_default_routes_on_create
  vpc_routing_mode                    = each.value.vpc_routing_mode
  vpc_name                            = each.value.vpc_name
  subnets                             = each.value.subnets
  routes                              = each.value.routes
  firewall                            = each.value.firewall
}

module "webapp-vm" {
  source       = "./modules/vm"
  image        = var.webapp-vm.image
  name         = var.webapp-vm.name
  machine_type = var.webapp-vm.machine_type
  size         = var.webapp-vm.size
  subnet       = var.webapp-vm.subnet
  tags         = var.webapp-vm.tags
  type         = var.webapp-vm.type
  zone         = var.webapp-vm.zone
  network_tier = var.webapp-vm.network_tier
}
