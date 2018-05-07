//Security Groups
resource "aws_security_group" "orchestrator_ha" {
  vpc_id      = "${var.vpc_id}"
  description = "Orchestrator App security group."
  name        = "Orchestrator App security group."
}

resource "aws_security_group" "orchestrator_aurora" {
  name        = "Orchestrator RDS security group."
  description = "Orchestrator RDS security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "orchestrator_elb" {
  name = "Orchestrator ELB security group."
  description = "Orchestrator ELB security group."
  vpc_id = "${var.vpc_id}"
}

//Rules
resource "aws_security_group_rule" "aurora_ingress_01" {
  // Allow all traffic within the group for RDS access
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.orchestrator_aurora.id}"
  source_security_group_id = "${aws_security_group.orchestrator_ha.id}"
}
resource "aws_security_group_rule" "elb_ingress_01" {
  from_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.orchestrator_elb.id}"
  to_port = 80
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "elb_ingress_02" {
  from_port = 443
  protocol = "tcp"
  security_group_id = "${aws_security_group.orchestrator_elb.id}"
  to_port = 443
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

//Data
#data "aws_ami" "amazon_linux" {
#  most_recent = true
#  owners = ["amazon"]
#
#  filter {
#    name = "name"
#    values = ["amazon/amzn-ami-hvm-*"]
#  }
#}

//Modules
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "1.2.0"
  name  = "${var.elb_name}"
  subnets = ["${var.subnets}"]
  security_groups = ["${aws_security_group.orchestrator_elb.id}"]
  internal = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = [
    {
      target              = "HTTP:80/"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]

  // ELB attachments
  number_of_instances = "${var.ec2_instace_count}"
  instances           = ["${module.aws-ec2.id}"]
}

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
  private-subnets = ["${var.subnets}"]
}

module "aws-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.3.0"

  name = "${var.ec2_name}"
  instance_count = "${var.ec2_instace_count}"
  ami = "${var.ec2_ami}"
  instance_type = "${var.ec2_instace_type}"
  key_name = "${var.ec2_key_name}"
  monitoring = "true"
  vpc_security_group_ids = ["${aws_security_group.orchestrator_ha.id}"]
  subnet_id = "${element(var.subnets, 0)}"
}

