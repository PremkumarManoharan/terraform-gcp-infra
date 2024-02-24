module "vpcs" {
  for_each                            = { for s in toset(var.vpcs) : s.vpc_name => s }
  source                              = "./modules/vpc"
  vpc_auto_create_subnetworks         = each.value.vpc_auto_create_subnetworks
  vpc_delete_default_routes_on_create = each.value.vpc_delete_default_routes_on_create
  vpc_routing_mode                    = each.value.vpc_routing_mode
  vpc_name                            = each.value.vpc_name
  subnets                             = each.value.subnets
  routes                              = each.value.routes
  firewall                            = each.value.firewall
  psconnect                           = each.value.psconnect
  private_vpc_connection_service      = each.value.private_vpc_connection_service
}


module "sql-instance-database" {
  depends_on     = [ module.vpcs ]
  source = "./modules/sql_instance"
  sql_instance = var.sql_instance
  private_network = module.vpcs["vpc-network"].vpc.self_link
}
module "vms" {
  for_each       = { for s in toset(var.vms) : s.name => s }
  depends_on     = [ module.sql-instance-database ]
  source         = "./modules/vm"
  family         = each.value.family
  family_project = each.value.family_project
  name           = each.value.name
  machine_type   = each.value.machine_type
  size           = each.value.size
  subnet         = each.value.subnet
  tags           = each.value.tags
  type           = each.value.type
  zone           = each.value.zone
  network_tier   = each.value.network_tier
  dbhostname     = module.sql-instance-database.PrivateIp
  database       = var.database
  dbuser         = module.sql-instance-database.username
  dbpassword     = module.sql-instance-database.password
}




output "private_ip" {
  value = module.sql-instance-database.PrivateIp
}
output "username" {
  value = module.sql-instance-database.username
}
output "password" {
  value = module.sql-instance-database.password
}
output "vpc" {
  value = module.vpcs["vpc-network"].vpc
}
