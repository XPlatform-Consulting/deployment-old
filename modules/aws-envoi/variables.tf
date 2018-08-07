variable "vpc_id" {}
variable "private-subnets" {
  type = "list"
  description = "A list of VPC subnet IDs."
}

#Elasticsearch
variable "elasticsearch_domain_name" {
  description = "Name of the domain."
}
variable "elasticsearch_version" {
  description = "The version of ElasticSearch to deploy."
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

#RDS Cluster
variable "cluster_identifier" {
  description = "Cluster Identifier"
}
variable "engine_type" {
  description = "The name of the database engine to be used for this DB cluster. aurora-postgresql or aurora"
}
variable "engine_version" {
  description = "The database engine version."
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
variable "availability_zones" {
  type = "list"
  description = "A list of EC2 Availability Zones that instances in the DB cluster can be created in."
}
variable "instance_count" {
  description = "The number of instances to run"
}
variable "rds_instance_class" {
  description = "The instance class to use."
}
variable "subnet_group_name" {
  description = "The name of the DB subnet group."
}

#EC2 instance
variable "ec2_name" {

}
variable "ec2_count" {

}
variable "ec2_instance_type" {

}
variable "ec2_key_name" {

}
variable "ec2_subnet_id" {

}