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
  for_each        = { for s in toset(var.sql_instance) : s.sql_instance_name => s }
  depends_on      = [ module.vpcs ]
  source          = "./modules/sql_instance"
  sql_instance    = each.value
  private_network = module.vpcs[each.value.vpc_name].vpc.self_link
}

module "service_accounts" {
  for_each       = { for s in toset(var.service_accounts) : s.account_id => s }
  source = "./modules/serviceAccount"
  account_id = each.value.account_id
  display_name = each.value.display_name
}

module "projectIAMbinding" {
  source = "./modules/projectIAMbinding"
  depends_on = [ module.service_accounts ]
  for_each = { for s in toset(var.project_role_bindings) : s.role => s }
  email = module.service_accounts[each.value.account_id].email
  role = each.value.role
  userType = each.value.userType
  project = each.value.project
}
module "vms" {
  for_each       = { for s in toset(var.vms) : s.name => s }
  depends_on     = [ module.sql-instance-database, module.projectIAMbinding ]
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
  dbhostname     = module.sql-instance-database[each.value.database_instance].PrivateIp
  database       = each.value.database_name
  dbuser         = module.sql-instance-database[each.value.database_instance].username
  dbpassword     = module.sql-instance-database[each.value.database_instance].password
  email          = module.service_accounts[each.value.account_id].email 
}

module "dns_zone" {
  for_each       = { for s in toset(var.dns_zone_records) : s.domain_name => s }
  depends_on = [ module.vms ]
  source = "./modules/dns"
  dns_zone_name = each.value.dns_zone_name
  domain_name = each.value.domain_name
  record_rrdatas = [module.vms[each.value.instance_name].PublicIp]
  record_type = each.value.record_type
  record_ttl = each.value.record_ttl
}
