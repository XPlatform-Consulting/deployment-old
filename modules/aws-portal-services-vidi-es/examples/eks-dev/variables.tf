variable "aws_region" {

}
variable "eks_worker_size" {
  default = "t2.xlarge"
}
variable "eks_worker_desired_capacity" {
  default = "3"
}
variable "eks_worker_max_capacity" {
  default = "4"
}
variable "eks_worker_min_capacity" {
  default = "1"
}
variable "eks_ingress_cidr_block" {

}
variable "portal_rds_master_password" {

}
variable "portal_rds_master_username" {

}
variable "vidi_rds_master_password" {

}
variable "vidi_rds_master_username" {

}
variable "vidi_broker_password" {

}
variable "vidi_broker_username" {

}
variable "activiti_rds_master_username" {

}
variable "activiti_rds_master_password" {

}
variable "portal_elasticsearch_domain_name" {}
variable "portal_elasticsearch_instance_size" {}
variable "portal_elasticsearch_snapshot_start_hour" {}
variable "portal_elasticache_cluster_port" {}
variable "portal_elasticache_subnet_group_name" {}
variable "portal_elasticache_cluster_id" {}
variable "portal_elasticache_node_size" {}
variable "portal_elasticache_node_count" {}
variable "activiti_rds_cluster_identifier" {}
variable "activiti_rds_cluster_database_name" {}
variable "activiti_rds_cluster_instance_count" {}
variable "activiti_rds_cluster_instance_type" {}
variable "activiti_rds_cluster_subnet_group_name" {}
variable "portal_rds_cluster_identifier" {}
variable "portal_rds_cluster_database_name" {}
variable "portal_rds_cluster_instance_count" {}
variable "portal_rds_cluster_instance_type" {}
variable "portal_rds_cluster_subnet_group_name" {}
variable "vidi_rds_cluster_identifier" {}
variable "vidi_rds_cluster_database_name" {}
variable "vidi_rds_cluster_instance_count" {}
variable "vidi_rds_cluster_instance_size" {}
variable "vidi_rds_cluster_subnet_group_name" {}
variable "vidi_broker_name" {}
variable "vidi_broker_instance_type" {}
variable "vidi_elasticsearch_domain_name" {}
variable "vidi_elasticsearch_instance_type" {}
variable "vidi_elasticsearch_automated_snapshot_start_hour" {}