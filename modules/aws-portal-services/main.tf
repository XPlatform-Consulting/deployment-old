resource "aws_security_group" "portal" {
  vpc_id      = "${var.vpc_id}"
  description = "Portal App security group."
  name        = "Portal App security group"
}

resource "aws_security_group" "portal_elasticache_cluster" {
  name        = "Portal Elasticache security group."
  description = "Portal Elasticache security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "portal_elasticsearch_cluster" {
  name        = "Portal Elasticsearch security group."
  description = "Portal Elasticsearch security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "portal_rds_cluster" {
  name        = "Portal RDS security group."
  description = "Portal RDS security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "elasticache_cluster_ingress_01" {
  // Allow all traffic within the group for Elasticache access
  type                     = "ingress"
  from_port                = "${var.elasticache_cluster_port}"
  to_port                  = "${var.elasticache_cluster_port}"
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.portal_elasticache_cluster.id}"
  source_security_group_id = "${aws_security_group.portal.id}"
}

resource "aws_security_group_rule" "elasticsearch_cluster_ingress_01" {
  // Allow all traffic within the group for Elasticsearch access
  type                     = "ingress"
  from_port                = "-0"
  to_port                  = "-0"
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.portal_elasticsearch_cluster.id}"
  source_security_group_id = "${aws_security_group.portal.id}"
}

resource "aws_security_group_rule" "rds_cluster_ingress_01" {
  // Allow all traffic within the group for RDS access
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.portal_rds_cluster.id}"
  source_security_group_id = "${aws_security_group.portal.id}"
}



module "aws-aurora-activiti" {
  source = "../aws-aurora"
  cluster_identifier = "${var.activiti_cluster_identifier}"
  engine_type = "${var.activiti_engine_type}"
  database_name = "${var.activiti_database_name}"
  master_username = "${var.activiti_master_username}"
  master_password = "${var.activiti_master_password}"
  security_group_id = ["${aws_security_group.portal_rds_cluster.id}"]
  instance_count = "${var.activiti_instance_count}"
  instance_class = "${var.activiti_rds_instance_class}"
  subnet_group_name = "${var.activiti_subnet_group_name}"
  private-subnets = ["${var.private-subnets}"]
}

module "aws-aurora" {
  source = "../aws-aurora"
  cluster_identifier = "${var.cluster_identifier}"
  engine_type = "${var.engine_type}"
  database_name = "${var.database_name}"
  master_username = "${var.master_username}"
  master_password = "${var.master_password}"
  security_group_id = ["${aws_security_group.portal_rds_cluster.id}"]
  instance_count = "${var.instance_count}"
  instance_class = "${var.rds_instance_class}"
  subnet_group_name = "${var.subnet_group_name}"
  private-subnets = ["${var.private-subnets}"]
}

module "aws-elasticache" {
  source = "../aws-elasticache"
  elasticache_subnet_group = "${var.elasticache_subnet_group}"
  elasticache_cluser_id = "${var.elasticache_cluser_id}"
  elasticache_engine = "memcached"
  elasticache_node_type = "${var.elasticache_node_type}"
  elasticache_cluster_port = "${var.elasticache_cluster_port}"
  num_cache_nodes = "${var.num_cache_nodes}"
  parameter_group_name = "${var.parameter_group_name}"
  private-subnets = ["${var.private-subnets}"]
  elasticache_security_group_id = ["${aws_security_group.portal_elasticache_cluster.id}"]
}

module "aws-elasticsearch" {
  source = "../aws-elasticsearch"
  elasticsearch_domain_name = "${var.elasticsearch_domain_name}"
  elasticsearch_version = "1.5"
  elasticsearch_instnace_type = "${var.elasticsearch_instnace_type}"
  elasticsearch_ebs_enabled = "${var.elasticsearch_ebs_enabled}"
  elasticsearch_volume_type = "${var.elasticsearch_volume_type}"
  elasticsearch_volume_size = "${var.elasticsearch_volume_size}"
  elasticsearch_rest_index = "${var.elasticsearch_rest_index}"
  elasticsearch_security_group_ids = ["${aws_security_group.portal_elasticsearch_cluster.id}"]
  elasticsearch_automated_snapshot_start_hour = "${var.elasticsearch_automated_snapshot_start_hour}"
  elasticsearch_subnet = ["${var.elasticsearch_subnet}"]
}

module "aws-vidispine-services" {
  source = "../aws-vidispine-services"
  vpc_id = "${var.vpc_id}"
  private_subnet_ids = "${var.private-subnets}"
  vidi_cluster_identifier = "${var.vidi_cluster_identifier}"
  vidi_database_name = "${var.vidi_database_name}"
  vidi_instance_count = "${var.vidi_instance_count}"
  vidi_master_password = "${var.vidi_master_password}"
  vidi_master_username = "${var.vidi_master_username}"
  vidi_rds_instance_class = "${var.vidi_rds_instance_class}"
  vidi_subnet_group_name = "${var.vidi_subnet_group_name}"
  vidi_broker_name = "${var.vidi_broker_name}"
  vidi_broker_instance_type = "${var.vidi_broker_instance_type}"
  vidi_broker_username = "${var.vidi_broker_username}"
  vidi_broker_password = "${var.vidi_broker_password}"
}