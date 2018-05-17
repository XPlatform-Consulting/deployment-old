provider "aws" {
  region = "${var.region_id}"
}

module "aws-aspera-orchestrator" {
  source = "../../"
  vpc_id = "${var.vpc_id}"
  subnet_1 = "${var.subnet_1}"
  subnet_2 = "${var.subnet_2}"
  aurora_cluster_identifier = "${var.aurora_cluster_identifier}"
  aurora_database_name = "${var.aurora_database_name}"
  aurora_master_username = "${var.aurora_master_username}"
  aurora_master_password = "${var.aurora_master_password}"
  aurora_instance_class = "${var.aurora_instance_class}"
  aurora_instance_count = "${var.aurora_instance_count}"
  aurora_subnet_group_name = "${var.aurora_subnet_group_name}"
  ec2_ami = "${var.ec2_ami}"
  ec2_name = "${var.ec2_name}"
  ec2_instace_type = "${var.ec2_instace_type}"
  ec2_key_name = "${var.ec2_key_name}"
}

output "orchestrator_public_ip" {
  value = "${module.aws-aspera-orchestrator.orchestrator_public_ip}"
}
output "orchestrator_private_ip" {
  value = "${module.aws-aspera-orchestrator.orchestrator_private_ip}"
}
output "rds_endpoint" {
  value = "${module.aws-aspera-orchestrator.rds_endpoint}"
}