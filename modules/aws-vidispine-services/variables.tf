variable "vpc_id" {
  description = "The ID of your AWS VPC"
}
variable "private_subnet_ids" {
  type = "list"
  description = "A list of VPC subnet IDs."
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
  description = "The number of instances to run"
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
  description = "The type of instance used for the Vidispine broker"
  default = "mq.t2.micro"
}
variable "vidi_broker_username" {
  description = "The username for the Vidispine broker"
}
variable "vidi_broker_password" {
  description = "The password for the Vidispine broker"
}
