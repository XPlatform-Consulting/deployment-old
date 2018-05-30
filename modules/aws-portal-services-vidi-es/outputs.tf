output "portal_security_group" {
  value = "${aws_security_group.portal.id}"
}
output "portal_elasticsearch_endpoint" {
  value = "${module.aws-elasticsearch.elasticsearch_endpoint}"
}
output "portal_elasticache_endpoint" {
  value = "${module.aws-elasticache.elasticache_endpoint}"
}
output "portal_rds_cluster_endpoint" {
  value = "${module.aws-aurora.aurora_endpoint}"
}
output "vidispine_security_group" {
  value = "${module.aws-vidispine-services-es.vidispine_security_group}"
}
output "vidi_rds_cluster_endpoint" {
  value = "${module.aws-vidispine-services-es.vidi_aurora_endpoint}"
}
output "vidi_broker_endpoints" {
  value = "${module.aws-vidispine-services-es.vidi_broker_endpoints}"
}
output "activiti_rds_cluster_endpoint" {
  value = "${module.aws-aurora-activiti.aurora_endpoint}"
}
output "vidi_elasticsearch_endpoint" {
  value = "${module.aws-vidispine-services-es.vidi_elasticsearch_endpoint}"
}