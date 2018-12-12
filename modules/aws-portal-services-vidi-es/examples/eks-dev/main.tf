provider "aws" {
  region = "${var.aws_region}"
}

module "aws-portal-services" {
  source = "../../"
  vpc_id = "${module.portal-eks.eks-vpc}"
  private-subnets = ["${module.portal-eks.eks-subnet-ids}"]
  cluster_security_group = "${module.portal-eks.eks-sg}"

  #Portal Elasticsearch
  elasticsearch_domain_name = "${var.portal_elasticsearch_domain_name}"
  elasticsearch_instance_type = "${var.portal_elasticsearch_instance_size}"
  elasticsearch_ebs_enabled = true
  elasticsearch_volume_type = "gp2"
  elasticsearch_volume_size = 10
  elasticsearch_rest_index = "true"
  elasticsearch_automated_snapshot_start_hour = "${var.portal_elasticsearch_snapshot_start_hour}"
  elasticsearch_subnet = ["${element(module.portal-eks.eks-subnet-ids, 1)}"]

  #Portal Elasticache
  elasticache_cluster_port = "${var.portal_elasticache_cluster_port}"
  elasticache_subnet_group = "${var.portal_elasticache_subnet_group_name}"
  elasticache_cluser_id = "${var.portal_elasticache_cluster_id}"
  elasticache_node_type = "${var.portal_elasticache_node_size}"
  num_cache_nodes = "${var.portal_elasticache_node_count}"
  parameter_group_name = "default.memcached1.5"

  #Activiti RDS Cluster
  activiti_cluster_identifier = "${var.activiti_rds_cluster_identifier}"
  activiti_database_name = "${var.activiti_rds_cluster_database_name}"
  activiti_engine_type = "aurora-postgresql"
  activiti_instance_count = "${var.activiti_rds_cluster_instance_count}"
  activiti_master_password = "${var.activiti_rds_master_password}"
  activiti_master_username = "${var.activiti_rds_master_username}"
  activiti_rds_instance_class = "${var.activiti_rds_cluster_instance_type}"
  activiti_subnet_group_name = "${var.activiti_rds_cluster_subnet_group_name}"

  #Portal RDS Cluster
  cluster_identifier = "${var.portal_rds_cluster_identifier}"
  engine_type = "aurora-postgresql"
  database_name = "${var.portal_rds_cluster_database_name}"
  master_username = "${var.portal_rds_master_username}"
  master_password = "${var.portal_rds_master_password}"
  instance_count = "${var.portal_rds_cluster_instance_count}"
  rds_instance_class = "${var.portal_rds_cluster_instance_type}"
  subnet_group_name = "${var.portal_rds_cluster_subnet_group_name}"

  #Vidispine
  #vidi_availability_zones = ["us-east-1a", "us-east-1b"]
  vidi_cluster_identifier = "${var.vidi_rds_cluster_identifier}"
  vidi_database_name = "${var.vidi_rds_cluster_database_name}"
  vidi_engine_type = "aurora-postgresql"
  #vidi_engine_version = "9.6"
  vidi_instance_count = "${var.vidi_rds_cluster_instance_count}"
  vidi_master_password = "${var.vidi_rds_master_password}"
  vidi_master_username = "${var.vidi_rds_master_username}"
  vidi_rds_instance_class = "${var.vidi_rds_cluster_instance_size}"
  vidi_subnet_group_name = "${var.vidi_rds_cluster_subnet_group_name}"
  vidi_broker_name = "${var.vidi_broker_name}"
  vidi_broker_instance_type = "${var.vidi_broker_instance_type}"
  vidi_broker_username = "${var.vidi_broker_username}"
  vidi_broker_password = "${var.vidi_broker_password}"
  vidi_broker_subnet_ids = ["${element(module.portal-eks.eks-subnet-ids, 1)}"]
  vidi_elasticsearch_domain_name = "${var.vidi_elasticsearch_domain_name}"
  vidi_elasticsearch_instance_type = "${var.vidi_elasticsearch_instance_type}"
  vidi_elasticsearch_ebs_enabled = true
  vidi_elasticsearch_volume_type = "gp2"
  vidi_elasticsearch_volume_size = 10
  vidi_elasticsearch_rest_index = "true"
  vidi_elasticsearch_subnet = ["${element(module.portal-eks.eks-subnet-ids, 1)}"]
  vidi_elasticsearch_automated_snapshot_start_hour = "${var.vidi_elasticsearch_automated_snapshot_start_hour}"
}

module "portal-eks" {
  source = "../../../aws-eks"
  cluster-name = "Portal-EKS-Dev"
  vpc_subnet_count = "3"
  ingress_cidr_blocks = ["${var.eks_ingress_cidr_block}"]
  worker-size = "${var.eks_worker_size}"
  worker_desired_capacity = "${var.eks_worker_desired_capacity}"
  worker_max_capacity = "${var.eks_worker_max_capacity}"
  worker_min_capacity = "${var.eks_worker_min_capacity}"
}

locals {
  portal_config = <<PORTALCONFIG


apiVersion: v1
data:
    #Vidispine
    ACTIVEMQ_BROKER_URL: ${element(module.aws-portal-services.vidi_broker_endpoints, 0)}
    VIDISPINE_ELASTICSEARCH_URL: https://${module.aws-portal-services.vidi_elasticsearch_endpoint}/
    VIDISPINE_DATABASE_HOST: ${module.aws-portal-services.vidi_rds_cluster_endpoint}
    VIDISPINE_DATABASE_NAME: vidispinedb
    JAVA_OPTS: "-Xmx8192m"
    AWS_REGION: ${var.aws_region}
    S3_URI_THUMBNAIL_STORAGE: none
    S3_URI_GENERAL_STORAGE: none
    S3_URI_HOTFOLDER_STORAGE: none
    TRANSCODE_UUID: none
    #Portal
    ACTIVITI_DATABASE_HOST: ${module.aws-portal-services.activiti_rds_cluster_endpoint}
    ACTIVITI_DATABASE_NAME: actvitidb
    PORTAL_DATABASE_HOST: ${module.aws-portal-services.portal_rds_cluster_endpoint}
    PORTAL_DATABASE_NAME: portaldb
    ELASTICSEARCH_HOST: https://${module.aws-portal-services.portal_elasticsearch_endpoint}:443/
    MEMCACHED_HOST: ${module.aws-portal-services.portal_elasticache_endpoint}
kind: ConfigMap
metadata:
  name: vidispine-portal
PORTALCONFIG
}

output "portal_security_group" {
  value = "${module.aws-portal-services.portal_security_group}"
}
output "portal_elasticsearch_endpoint" {
  value = "${module.aws-portal-services.portal_elasticsearch_endpoint}"
}
output "portal_elasticache_endpoint" {
  value = "${module.aws-portal-services.portal_elasticache_endpoint}"
}
output "portal_rds_cluster_endpoint" {
  value = "${module.aws-portal-services.portal_rds_cluster_endpoint}"
}
output "vidispine_security_group" {
  value = "${module.aws-portal-services.vidispine_security_group}"
}
output "vidi_rds_cluster_endpoint" {
  value = "${module.aws-portal-services.vidi_rds_cluster_endpoint}"
}
output "vidi_broker_endpoints" {
  value = "${module.aws-portal-services.vidi_broker_endpoints}"
}
output "activiti_rds_cluster_endpoint" {
  value = "${module.aws-portal-services.activiti_rds_cluster_endpoint}"
}
output "vidispine_elasticsearch_endpoint" {
  value = "${module.aws-portal-services.vidi_elasticsearch_endpoint}"
}
output "config_map_aws_auth" {
  value = "${module.portal-eks.config_map_aws_auth}"
}
output "portal_kubeconfig" {
  value = "${local.portal_config}"
}