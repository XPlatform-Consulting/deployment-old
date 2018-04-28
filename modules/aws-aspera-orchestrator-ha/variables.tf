variable "vpc_id" {}
variable "subnets" {
  type = "list"
  description = "The ID of your subnets"
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
  description = "The number of instaces to run"
}
variable "aurora_subnet_group_name" {
  description = "The name of the DB subnet group."
}

#EC2 Instace
variable "ec2_name" {
  description = "The name of the ec2 instaces to be created"
}
variable "ec2_instace_type" {
  description = "The type of ec2 instace to be created"
  default = "m5. large"
}
variable "ec2_instace_count" {
  description = "The number of ec2 instances to be created"
}
variable "ec2_key_name" {
  description = "The name of the key to be used to connect to the ec2 instaces"
}
variable "ec2_ami" {}


#ELB
variable "elb_name" {
  description = "The name of the ELB to be created"
}