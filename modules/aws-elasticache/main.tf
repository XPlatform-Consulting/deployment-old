resource "aws_elasticache_cluster" "default" {
  cluster_id = "${var.elasticache_cluser_id}"
  engine = "${var.elasticache_engine}"
  node_type            = "${var.elasticache_node_type}"
  port                 = "${var.elasticache_cluster_port}"
  num_cache_nodes      = "${var.num_cache_nodes}"
  parameter_group_name = "${var.parameter_group_name}"
  subnet_group_name = "${aws_elasticache_subnet_group.default.name}"
  security_group_ids = ["${var.elasticache_security_group_id}"]
}

resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.elasticache_subnet_group}"
  subnet_ids = ["${var.private-subnets}"]
}