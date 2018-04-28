resource "aws_rds_cluster" "default" {
  cluster_identifier = "${var.cluster_identifier}"
  engine = "${var.engine_type}"
  database_name = "${var.database_name}"
  master_username = "${var.master_username}"
  master_password = "${var.master_password}"
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "default" {
  count = "${var.instance_count}"
  engine = "${var.engine_type}"
  identifier = "${var.cluster_identifier}-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class = "${var.instance_class}"
  publicly_accessible = false
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
}

resource "aws_db_subnet_group" "default" {
  name = "${var.subnet_group_name}"
  subnet_ids = ["${var.private-subnets}"]

  tags {
    Name = "AWS subnet group"
  }
}
