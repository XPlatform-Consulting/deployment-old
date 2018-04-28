output "elasticache_endpoint" {
  value = "${aws_elasticache_cluster.default.cluster_address}"
}