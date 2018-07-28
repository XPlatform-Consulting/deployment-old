variable "vpc_id" {}

variable "worker_count" {
  default = 2
}

variable "master_count" {
  default = 1
}

#EC2 Instace
variable "ec2_master_name" {

}
variable "ec2_worker_name" {

}
variable "ec2_instance_type" {

}
variable "ec2_key_name" {

}
variable "ec2_subnet_id" {

}
variable "security_group_ids" {
  type = "list"
}