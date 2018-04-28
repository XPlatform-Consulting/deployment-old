output "envoi_vidispine_security_group" {
  value = "${aws_security_group.envoi_vidispine.id}"
}
output "elasticsearch_cluster_security_group" {
  value = "${aws_security_group.vidispine_elasticsearch_cluster.id}"
}
output "rds_cluster_security_group" {
  value = "${aws_security_group.vidispine_rds_cluster.id}"
}
output "amazonmq_security_group" {
  value = "${aws_security_group.vidispine_amazonmq.id}"
}
output "vidi_broker_endpoints" {
  value = "${module.aws-amazonmq.amazonmq_endpoints}"
}
output "vidi_aurora_endpoint" {
  value = "${module.aws-aurora.aurora_endpoint}"
}