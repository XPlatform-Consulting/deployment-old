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
  description = "The number of instances to run"
}

variable "instance_class" {
  description = "The instance class to use."
}

variable "security_group_id" {
  type = "list"
  description = "VPC security group to associate with the Cluster."
}

variable "subnet_group_name" {
  description = "The name of the DB subnet group."
}

variable "private-subnets" {
  type = "list"
  description = "A list of VPC subnet IDs."
}