resource "aws_mq_broker" "vidispine-mq" {
  broker_name = "${var.broker_name}"
  engine_type = "${var.broker_type}"
  engine_version = "${var.broker_version}"
  host_instance_type = "${var.broker_instance_type}"
  subnet_ids = ["${var.broker_subnet_ids}"]
  security_groups = ["${var.broker_security_groups}"]
  "user" {
    password = "${var.broker_password}"
    username = "${var.broker_username}"
  }
}
