variable "vpc_id" {}
variable "private-subnets" {
  type = "list"
  description = "A list of VPC subnet IDs."
}

#Elasticsearch
variable "elasticsearch_domain_name" {
  description = "Name of the domain."
}
variable "elasticsearch_instnace_type" {
  description = "Instance type of data nodes in the cluster."
}
variable "elasticsearch_ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes in the domain."
}
variable "elasticsearch_volume_type" {
  description = "The type of EBS volumes attached to data nodes."
}
variable "elasticsearch_volume_size" {
  description = "The size of EBS volumes attached to data nodes (in GB). Required if ebs_enabled is set to true."
}
variable "elasticsearch_rest_index" {
  description = ""
}
variable "elasticsearch_subnet" {
  type = "list"
  description = "List of VPC Subnet IDs for the Elasticsearch domain endpoints to be created in."
}
variable "elasticsearch_automated_snapshot_start_hour" {
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain."
}

#Elasticache
variable "elasticache_subnet_group" {
  description = "The name of the elasticache subnet group."
}
variable "elasticache_cluser_id" {
  description = "Group identifier."
}
variable "elasticache_node_type" {
  description = "The compute and memory capacity of the nodes."
}
variable "elasticache_cluster_port" {
  description = "The port number on which each of the cache nodes will accept connections."
}
variable "num_cache_nodes" {
  description = "The initial number of cache nodes that the cache cluster will have."
}
variable "parameter_group_name" {
  default = "Name of the parameter group to associate with this cache cluster."
}

#RDS Cluster
variable "cluster_identifier" {
  description = "Cluster Identifier"
}
variable "engine_type" {
  description = "The name of the database engine to be used for this DB cluster. aurora-postgresql or aurora"
}
variable "database_name" {
  description = "Name for an automatically created database on cluster creation."
}
variable "master_username" {
  description = "Username for the master DB user."
}
variable "master_password" {
  description = "Password for the master DB user."
}
variable "instance_count" {
  description = "The number of instaces to run"
}
variable "rds_instance_class" {
  description = "The instance class to use."
}
variable "subnet_group_name" {
  description = "The name of the DB subnet group."
}

#Activiti RDS Cluster
variable "activiti_cluster_identifier" {
  description = "Cluster Identifier"
}
variable "activiti_engine_type" {
  description = "The name of the database engine to be used for this DB cluster. aurora-postgresql or aurora"
}
variable "activiti_database_name" {
  description = "Name for an automatically created database on cluster creation."
}
variable "activiti_master_username" {
  description = "Username for the master DB user."
}
variable "activiti_master_password" {
  description = "Password for the master DB user."
}
variable "activiti_instance_count" {
  description = "The number of instaces to run"
}
variable "activiti_rds_instance_class" {
  description = "The instance class to use."
}
variable "activiti_subnet_group_name" {
  description = "The name of the DB subnet group."
}

#Vidispine RDS Cluster
variable "vidi_cluster_identifier" {
  description = "Cluster Identifier"
}
variable "vidi_engine_type" {
  description = "The name of the database engine to be used for this DB cluster. aurora-postgresql or aurora"
}
variable "vidi_engine_version" {
  description = "The database engine version."
}
variable "vidi_database_name" {
  description = "Name for an automatically created database on cluster creation."
}
variable "vidi_master_username" {
  description = "Username for the master DB user."
}
variable "vidi_master_password" {
  description = "Password for the master DB user."
}
variable "vidi_availability_zones" {
  type = "list"
  description = "A list of EC2 Availability Zones that instances in the DB cluster can be created in."
}
variable "vidi_instance_count" {
  description = "The number of instaces to run"
}
variable "vidi_rds_instance_class" {
  description = "The instance class to use."
}
variable "vidi_subnet_group_name" {
  description = "The name of the DB subnet group."
}

#Vidispine Amazon MQ
variable "vidi_broker_name" {
  description = "The name of the broker created for Vidispine"
}
variable "vidi_broker_instance_type" {
  description = "The type of instace used for the Vidispine broker"
}
variable "vidi_broker_username" {
  description = "The username for the Vidispine broker"
}
variable "vidi_broker_password" {
  description = "The password for the Vidispine broker"
}
variable "vidi_broker_subnet_ids" {
  description = "A list of subnet ids to be used by Amazon MQ"
  type = "list"
}