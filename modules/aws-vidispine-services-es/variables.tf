variable "vpc_id" {
  description = "The ID of your AWS VPC"
}
variable "private_subnet_ids" {
  type = "list"
  description = "A list of VPC subnet IDs."
}

variable "cluster_security_group" {
  description = "The security group of the cluster to host vidispine"
}

#RDS Cluster
variable "vidi_cluster_identifier" {
  description = "Cluster Identifier"
  default = "vididb"
}
variable "vidi_database_name" {
  description = "Name for an automatically created database on cluster creation."
  default = "vididb"
}
variable "vidi_master_username" {
  description = "Username for the master DB user."
}
variable "vidi_master_password" {
  description = "Password for the master DB user."
}
variable "vidi_instance_count" {
  description = "The number of instaces to run"
  default = 2
}
variable "vidi_rds_instance_class" {
  description = "The instance class to use."
  default = "db.r4.large"
}
variable "vidi_subnet_group_name" {
  description = "The name of the DB subnet group."
  default = "vididb"
}

#Amazon MQ
variable "vidi_broker_name" {
  description = "The name of the broker created for Vidispine"
  default = "vidispinemq"
}
variable "vidi_broker_instance_type" {
  description = "The type of instace used for the Vidispine broker"
  default = "mq.t2.micro"
}
variable "vidi_broker_username" {
  description = "The username for the Vidispine broker"
}
variable "vidi_broker_password" {
  description = "The password for the Vidispine broker"
}

#Elasticsearch
variable "vidi_elasticsearch_domain_name" {
  description = "Name of the domain."
}
variable "vidi_elasticsearch_instnace_type" {
  description = "Instance type of data nodes in the cluster."
}
variable "vidi_elasticsearch_ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes in the domain."
}
variable "vidi_elasticsearch_volume_type" {
  description = "The type of EBS volumes attached to data nodes."
}
variable "vidi_elasticsearch_volume_size" {
  description = "The size of EBS volumes attached to data nodes (in GB). Required if ebs_enabled is set to true."
}
variable "vidi_elasticsearch_rest_index" {
  description = ""
}
variable "vidi_elasticsearch_subnet" {
  type = "list"
  description = "List of VPC Subnet IDs for the Elasticsearch domain endpoints to be created in."
}
variable "vidi_elasticsearch_automated_snapshot_start_hour" {
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain."
}