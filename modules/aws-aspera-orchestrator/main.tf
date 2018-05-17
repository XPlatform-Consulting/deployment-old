resource "aws_security_group" "orchestrator" {
  vpc_id      = "${var.vpc_id}"
  description = "Aspera Orchestrator security group."
  name        = "Aspera Orchestrator security group"
}

resource "aws_security_group" "orchestrator_aurora" {
  name        = "Orchestrator RDS security group."
  description = "Orchestrator RDS security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "aurora_ingress_01" {
  // Allow all traffic within the group for RDS access
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.orchestrator_aurora.id}"
  source_security_group_id = "${aws_security_group.orchestrator.id}"
}
resource "aws_security_group_rule" "aurora_ingress_02" {
  // Allow all traffic within the group for RDS access
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.orchestrator_aurora.id}"
  source_security_group_id = "${aws_security_group.orchestrator.id}"
}

resource "aws_security_group_rule" "aurora_egress" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.orchestrator_aurora.id}"
  to_port = 0
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "orchestrator_http" {
  // Allow http trafic to Orchestrator
  from_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.orchestrator.id}"
  to_port = 80
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "orchestrator_https" {
  // Allow https trafic to Orchestrator
  from_port = 443
  protocol = "tcp"
  security_group_id = "${aws_security_group.orchestrator.id}"
  to_port = 443
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "orchestrator_ssh" {
  // Allow SSH trafic to Orchestrator
  from_port = 22
  protocol = "tcp"
  security_group_id = "${aws_security_group.orchestrator.id}"
  to_port = 22
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "orchestrator_egress" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.orchestrator.id}"
  to_port = 0
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}

#data "aws_ami" "amazon_linux" {
#  most_recent = true
#  owners = ["amazon"]
#
#  filter {
#    name   = "name"
#    values = ["amzn-ami-hvm-*"]
#  }
#
#}

module "aws-aurora" {
  source = "../aws-aurora"
  cluster_identifier = "${var.aurora_cluster_identifier}"
  engine_type = "aurora-mysql"
  database_name = "${var.aurora_database_name}"
  master_username = "${var.aurora_master_username}"
  master_password = "${var.aurora_master_password}"
  security_group_id = ["${aws_security_group.orchestrator_aurora.id}"]
  instance_count = "${var.aurora_instance_count}"
  instance_class = "${var.aurora_instance_class}"
  subnet_group_name = "${var.aurora_subnet_group_name}"
  private-subnets = ["${var.subnet_1}", "${var.subnet_2}"]
}

module "aws-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.3.0"
  name = "${var.ec2_name}"
  ami = "${var.ec2_ami}"
  instance_type = "${var.ec2_instace_type}"
  key_name = "${var.ec2_key_name}"
  monitoring = "true"
  vpc_security_group_ids = ["${aws_security_group.orchestrator.id}"]
  subnet_id = "${var.subnet_1}"
  associate_public_ip_address = "true"
}