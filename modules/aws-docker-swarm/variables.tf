variable "vpc_id" {}

variable "worker_count" {
  default = 2
}

variable "master_count" {
  default = 1
}

#EC2 instance
variable "ec2_master_name" {
  default = "swarm_master"
}
variable "ec2_worker_name" {
  default = "swarm_worker"
}
variable "ec2_instance_type" {
  default = "m5.large"
}
variable "ec2_key_name" {

}
variable "ec2_subnet_id" {

}
variable "security_group_ids" {
  type = "list"
}
