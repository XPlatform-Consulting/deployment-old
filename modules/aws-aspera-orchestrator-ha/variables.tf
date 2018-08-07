variable "vpc_id" {}
variable "subnet_1" {
  description = "The ID of your first subnet"
}
variable "subnet_2" {
  description = "The ID of your second subnet"
}

#RDS Cluster
variable "aurora_cluster_identifier" {
  description = "Cluster Identifier"
}
variable "aurora_database_name" {
  description = "Name for an automatically created database on cluster creation."
}
variable "aurora_master_username" {
  description = "Username for the master DB user."
}
variable "aurora_master_password" {
  description = "Password for the master DB user."
}
variable "aurora_instance_class" {
  description = "The instance class to use."
}
variable "aurora_instance_count" {
  description = "The number of instances to run"
}
variable "aurora_subnet_group_name" {
  description = "The name of the DB subnet group."
}

#ELB
variable "elb_name" {
  description = "The name of the ELB to be created"
}

#Swarm
variable "swarm_master_name" {
  description = "The name of the new Swarm master node"
}
variable "swarm_worker_name" {
  description = "The name of the new Swarm workers"
}
variable "swarm_worker_count" {
  description = "The number of swarm workers to be created"
}
variable "swarm_instance_type" {
  description = "The type of instance to be used in the swarm ie. m5.large"
}
variable "swarm_key_name" {
  description = "The name of the key pair used to SSH into Swarm nodes"
}
