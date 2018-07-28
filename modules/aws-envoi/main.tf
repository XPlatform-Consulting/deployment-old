#Security groups
resource "aws_security_group" "envoi" {
  vpc_id      = "${var.vpc_id}"
  description = "Portal App security group."
  name        = "Portal App security group"
}

resource "aws_security_group" "elasticsearch_cluster" {
  name        = "Portal Elasticsearch security group."
  description = "Portal Elasticsearch security group."
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "rds_cluster" {
  name        = "Portal RDS security group."
  description = "Portal RDS security group."
  vpc_id      = "${var.vpc_id}"
}

#Security group rules
resource "aws_security_group_rule" "elasticsearch_cluster_ingress_01" {
  // Allow all traffic within the group for Elasticsearch access
  type                     = "ingress"
  from_port                = "-0"
  to_port                  = "-0"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elasticsearch_cluster.id}"
  source_security_group_id = "${aws_security_group.envoi.id}"
}

resource "aws_security_group_rule" "rds_cluster_ingress_01" {
  // Allow all traffic within the group for RDS access
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rds_cluster.id}"
  source_security_group_id = "${aws_security_group.envoi.id}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

#Modules
module "aws-aurora" {
  source = "../aws-aurora"
  cluster_identifier = "${var.cluster_identifier}"
  engine_type = "${var.engine_type}"
  engine_version = "${var.engine_version}"
  database_name = "${var.database_name}"
  master_username = "${var.master_username}"
  master_password = "${var.master_password}"
  security_group_id = ["${aws_security_group.rds_cluster.id}"]
  availability_zones = ["${var.availability_zones}"]
  instance_count = "${var.instance_count}"
  instance_class = "${var.rds_instance_class}"
  subnet_group_name = "${var.subnet_group_name}"
  private-subnets = ["${var.private-subnets}"]
}

module "aws-elasticsearch" {
  source = "../aws-elasticsearch"
  elasticsearch_domain_name = "${var.elasticsearch_domain_name}"
  elasticsearch_version = "${var.elasticsearch_version}"
  elasticsearch_instnace_type = "${var.elasticsearch_instnace_type}"
  elasticsearch_ebs_enabled = "${var.elasticsearch_ebs_enabled}"
  elasticsearch_volume_type = "${var.elasticsearch_volume_type}"
  elasticsearch_volume_size = "${var.elasticsearch_volume_size}"
  elasticsearch_rest_index = "${var.elasticsearch_rest_index}"
  elasticsearch_security_group_ids = ["${aws_security_group.elasticsearch_cluster.id}"]
  elasticsearch_automated_snapshot_start_hour = "${var.elasticsearch_automated_snapshot_start_hour}"
  elasticsearch_subnet = ["${var.elasticsearch_subnet}"]
}

module "aws-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.3.0"
  name = "${var.ec2_name}"
  count = "${var.ec2_count}"
  ami = "${data.aws_ami.amazon_linux.id}"
  instance_type = "${var.ec2_instance_type}"
  key_name = "${var.ec2_key_name}"
  monitoring = "true"
  vpc_security_group_ids = "${aws_security_group.envoi.id}"
  subnet_id = "${var.ec2_subnet_id}"
}

#module "aws_vpc" {
#  source = "../aws_vpc"
#  name = "envoi-vpc"
#  cidr = "10.0.0.0/16"
#  azs = ["${var.availability_zones}"]
#  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
#  public_subnets = ["10.0.0.0/24"]
#  enable_nat_gateway = true
#  enable_vpn_gateway = true
#}