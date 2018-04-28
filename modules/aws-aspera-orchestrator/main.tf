resource "aws_security_group" "envoi_orchestrator_ha" {
  vpc_id      = "${var.vpc_id}"
  description = "Portal App security group."
  name        = "Portal App security group"
}

resource "aws_security_group" "orchestrator_aurora" {
  name        = "Portal RDS security group."
  description = "Portal RDS security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "aurora_ingress_01" {
  // Allow all traffic within the group for RDS access
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.orchestrator_aurora.id}"
  source_security_group_id = "${aws_security_group.envoi_orchestrator_ha.id}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

}

module "aws-aurora" {
  source = "../aws-aurora"
  cluster_identifier = "${var.cluster_identifier}"
  engine_type = "aurora-mysql"
  engine_version = "5.6"
  database_name = "${var.database_name}"
  master_username = "${var.master_username}"
  master_password = "${var.master_password}"
  security_group_id = ["${aws_security_group.orchestrator_aurora.id}"]
  availability_zones = ["${var.availability_zones}"]
  instance_count = "${var.instance_count}"
  instance_class = "${var.rds_instance_class}"
  subnet_group_name = "${var.subnet_group_name}"
  private-subnets = ["${var.private-subnets}"]
}

module "aws-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.3.0"
  name = "${var.ec2_name}"
  count = "${var.ec2_count}"
  ami = "${data.aws_ami.amazon_linux.id}"
  instance_type = "${var.ec2_instace_type}"
  key_name = "${var.ec2_key_name}"
  monitoring = "true"
  vpc_security_group_ids = "${aws_security_group.envoi_orchestrator_ha.id}"
  subnet_id = "${var.ec2_subnet_id}"
}