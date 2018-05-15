provider "aws" {
  region = "${var.aws_region}"
}

module "aws-aspera-orchestrator-ha" {
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
  elb_name = "${var.elb_name}"
  swarm_master_name = "${var.swarm_master_name}"
  swarm_worker_name = "${var.swarm_worker_name}"
  swarm_worker_count = "${var.swarm_worker_count}"
  swarm_instance_type = "${var.swarm_instance_type}"
  swarm_key_name = "${var.swarm_key_name}"
}

output "swarm_master_private_ip" {
  value = "${module.aws-aspera-orchestrator-ha.swarm_master_private_ip}"
}
output "swarm_workers_private_ip" {
  value = "${module.aws-aspera-orchestrator-ha.swarm_workers_private_ip}"
}
output "rds_cluster_endpoint" {
  value = "${module.aws-aspera-orchestrator-ha.rds_cluster_endpoints}"
}
output "swarm_master_public_ip" {
  value = "${module.aws-aspera-orchestrator-ha.swarm_master_public_ip}"
}
output "swarm_workers_public_ip" {
  value = "${module.aws-aspera-orchestrator-ha.swarm_workers_public_ip}"
}