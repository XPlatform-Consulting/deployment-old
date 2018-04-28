variable "vpc_id" {}
variable "private-subnets" {
  type = "list"
  description = "A list of VPC subnet IDs."
}

#RDS Cluster
variable "cluster_identifier" {
  description = "Cluster Identifier"
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
  description = "The number of instaces to run"
}
variable "rds_instance_class" {
  description = "The instance class to use."
}
variable "subnet_group_name" {
  description = "The name of the DB subnet group."
}

#EC2 Instace
variable "ec2_name" {
  description = "The name of the ec2 instaces to be created"
}
variable "ec2_count" {
  description = "The number of ec2 instaces to be created"
  default = "1"
}
variable "ec2_instace_type" {
  description = "The type of ec2 instace to be created"
  default = "m5. large"
}
variable "ec2_key_name" {
  description = "The name of the key to be used to connect to the ec2 instaces"
}
variable "ec2_subnet_id" {
  description = "The full subnet id for the new ec2 instaces"
}
