resource "aws_security_group" "vidispine" {
  vpc_id = "${var.vpc_id}"
  description = "Vidispine app security group."
  name = "Vidispine app security group."
}

resource "aws_security_group" "vidispine_elasticsearch_cluster" {
  name        = "vidispine Elasticsearch security group."
  description = "vidispine Elasticsearch security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "vidispine_rds_cluster" {
  name        = "vidispine RDS security group."
  description = "vidispine RDS security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "vidispine_amazonmq" {
  name        = "vidispine amazon mq security group."
  description = "vidispine amazon mq security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "vidispine_elasticsearch_cluster_ingress_01" {
  // Allow all traffic within the group for Elasticsearch access
  type                     = "ingress"
  from_port                = "-0"
  to_port                  = "-0"
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.vidispine_elasticsearch_cluster.id}"
  source_security_group_id = "${aws_security_group.vidispine.id}"
}

resource "aws_security_group_rule" "vidispine_rds_cluster_ingress_01" {
  // Allow all traffic within the group for RDS access
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.vidispine_rds_cluster.id}"
  source_security_group_id = "${aws_security_group.vidispine.id}"
}

resource "aws_security_group_rule" "vidispine_amazonmq_ingress_01" {
  type = "ingress"
  from_port = "-0"
  to_port = "-0"
  protocol = "-1"
  security_group_id = "${aws_security_group.vidispine_amazonmq.id}"
  source_security_group_id = "${aws_security_group.vidispine.id}"
}

module "aws-elasticsearch" {
  source = "../aws-elasticsearch"
  elasticsearch_domain_name = "${var.vidi_elasticsearch_domain_name}"
  elasticsearch_version = "6.0"
  elasticsearch_instnace_type = "${var.vidi_elasticsearch_instnace_type}"
  elasticsearch_ebs_enabled = "${var.vidi_elasticsearch_ebs_enabled}"
  elasticsearch_volume_type = "${var.vidi_elasticsearch_volume_type}"
  elasticsearch_volume_size = "${var.vidi_elasticsearch_volume_size}"
  elasticsearch_rest_index = "${var.vidi_elasticsearch_rest_index}"
  elasticsearch_security_group_ids = ["${aws_security_group.vidispine_elasticsearch_cluster.id}"]
  elasticsearch_automated_snapshot_start_hour = "${var.vidi_elasticsearch_automated_snapshot_start_hour}"
  elasticsearch_subnet = ["${var.vidi_elasticsearch_subnet}"]
}

module "aws-aurora" {
  source = "../aws-aurora"
  cluster_identifier = "${var.vidi_cluster_identifier}"
  engine_type = "aurora-postgresql"
  database_name = "${var.vidi_database_name}"
  master_username = "${var.vidi_master_username}"
  master_password = "${var.vidi_master_password}"
  security_group_id = ["${aws_security_group.vidispine_rds_cluster.id}"]
  instance_count = "${var.vidi_instance_count}"
  instance_class = "${var.vidi_rds_instance_class}"
  subnet_group_name = "${var.vidi_subnet_group_name}"
  private-subnets = ["${var.private_subnet_ids}"]
}

module "aws-amazonmq" {
  source = "../aws-amazonmq"
  broker_name = "${var.vidi_broker_name}"
  broker_type = "ActiveMQ"
  broker_version = "5.15.0"
  broker_instace_type = "${var.vidi_broker_instance_type}"
  broker_security_groups = "${aws_security_group.vidispine_amazonmq.id}"
  broker_username = "${var.vidi_broker_username}"
  broker_password = "${var.vidi_broker_password}"
  broker_subnet_ids = ["${element(var.private_subnet_ids, 1)}"]
}