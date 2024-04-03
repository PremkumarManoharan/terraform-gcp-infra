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
  depends_on      = [module.vpcs]
  source          = "./modules/sql-instance"
  sql_instance    = each.value
  private_network = module.vpcs[each.value.vpc_name].vpc.self_link
}

module "service_accounts" {
  for_each     = { for s in toset(var.service_accounts) : s.account_id => s }
  source       = "./modules/service-account"
  account_id   = each.value.account_id
  display_name = each.value.display_name
}

module "projectIAMbinding" {
  source     = "./modules/project-iam-binding"
  depends_on = [module.service_accounts]
  for_each   = { for s in toset(var.project_role_bindings) : s.role => s }
  email      = module.service_accounts[each.value.account_id].email
  role       = each.value.role
  userType   = each.value.userType
  project    = each.value.project
}
module "vms" {
  for_each       = { for s in toset(var.vms) : s.name => s }
  depends_on     = [module.sql-instance-database, module.projectIAMbinding]
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
  scopes         = each.value.sa_scopes
  pubsubtopic    = each.value.pubsubtopic
}

module "dns_zone" {
  for_each       = { for s in toset(var.dns_zone_records) : s.domain_name => s }
  depends_on     = [module.load-balancer]
  source         = "./modules/dns"
  dns_zone_name  = each.value.dns_zone_name
  domain_name    = each.value.domain_name
  record_rrdatas = [module.load-balancer["webapp-http-lb"].external_ip]
  record_type    = each.value.record_type
  record_ttl     = each.value.record_ttl
}
module "pub-sub" {
  for_each                   = { for s in toset(var.pub_sub_topics) : s.name => s }
  source                     = "./modules/pub-sub-topic"
  name                       = each.value.name
  message_retention_duration = each.value.message_retention_duration
}
module "vpc-connector" {
  depends_on = [module.vpcs]
  for_each   = { for s in toset(var.vpc_connectors) : s.name => s }
  source     = "./modules/vpc-connector"
  name       = each.value.name
  subnet     = each.value.subnet
}

module "cloud-function-serverless" {
  for_each                        = { for s in toset(var.cloud_functions) : s.name => s }
  source                          = "./modules/cloud-function"
  name                            = each.value.name
  location                        = each.value.location
  runtime                         = each.value.runtime
  entry_point                     = each.value.entry_point
  bucket                          = each.value.bucket
  object                          = each.value.object
  SENDGRID_API_KEY                = each.value.SENDGRID_API_KEY
  PG_DB                           = each.value.PG_DB
  PG_HOST                         = module.sql-instance-database[each.value.database_instance].PrivateIp
  PG_PASSWORD                     = module.sql-instance-database[each.value.database_instance].password
  PG_USER                         = module.sql-instance-database[each.value.database_instance].username
  vpc_connector                   = module.vpc-connector[each.value.vpc_connector_name].vpc_connector_self_link
  max_instance_count              = each.value.max_instance_count
  min_instance_count              = each.value.min_instance_count
  available_memory                = each.value.available_memory
  available_cpu                   = each.value.available_cpu
  timeout_seconds                 = each.value.timeout_seconds
  ingress_settings                = each.value.ingress_settings
  all_traffic_on_latest_revision  = each.value.all_traffic_on_latest_revision
  service_account_email_pubsub    = module.service_accounts[each.value.account_id_pubsub].email
  service_account_email_functions = module.service_accounts[each.value.account_id_function].email
  event_type                      = each.value.event_type
  pubsub_topic                    = module.pub-sub[each.value.topic].topicId
  retry_policy                    = each.value.retry_policy
  vpc_connector_egress_settings   = each.value.vpc_connector_egress_settings
  generation                      = each.value.generation
}

module "instance-template" {
  for_each       = { for s in toset(var.instance_templates) : s.name => s }
  source         = "./modules/instance-template"
  name           = each.value.name
  description    = each.value.description
  disk_size_gb   = each.value.disk_size_gb
  tags           = each.value.tags
  disk_type      = each.value.disk_type
  machine_type   = each.value.machine_type
  network_tier   = each.value.network_tier
  scopes         = each.value.scopes
  subnetwork     = each.value.subnetwork
  database       = each.value.database
  dbhostname     = module.sql-instance-database[each.value.database_instance].PrivateIp
  dbpassword     = module.sql-instance-database[each.value.database_instance].password
  dbuser         = module.sql-instance-database[each.value.database_instance].username
  email          = module.service_accounts[each.value.vm_service_account].email
  family         = each.value.family
  family_project = each.value.family_project
  pubsubtopic    = each.value.pubsubtopic

}

module "instance-group" {
  for_each             = { for s in toset(var.instance-groups) : s.igm.name => s }
  source               = "./modules/instance-group"
  instance_template_id = module.instance-template[each.value.instance_template].instance_template_id
  autoscaling          = each.value.autoscaling
  http-health-check    = each.value.http-health-check
  igm                  = each.value.igm
}
module "load-balancer" {
  for_each                        = { for s in toset(var.load-balancers) : s.name => s }
  source                          = "./modules/load-balancer"
  backend-group                   = module.instance-group["webapp-igm"].mig
  name                            = each.value.name
  project                         = each.value.project
  backend_port                    = each.value.backend_port
  backend_port_name               = each.value.backend_port_name
  backend_protocol                = each.value.backend_protocol
  backend_timeoout_sec            = each.value.backend_timeoout_sec
  enable_cdn                      = each.value.enable_cdn
  health_check_port               = each.value.health_check_port
  health_check_request_path       = each.value.health_check_request_path
  iap_config_enable               = each.value.iap_config_enable
  log_config_enable               = each.value.log_config_enable
  managed_ssl_certificate_domains = each.value.managed_ssl_certificate_domains
  ssl                             = each.value.ssl
  firewall_networks = [module.vpcs[each.value.vpc_network].vpc.self_link]
  target_tags = each.value.target_tags
  http_forward = each.value.http_forward
}
