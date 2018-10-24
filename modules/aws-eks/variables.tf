variable "cluster-name" {
  default = "terraform-eks"
  description = "Name of the EKS cluster"
  type    = "string"
}

#variable "vpc_cidr_block" {
#  default = "10.0.0.0/16"
#  description = "The CIDR block to use for the EKS VPC"
#}
variable "vpc_subnet_count" {
  default = 3
  description = "The number of subnets to create in the EKS VPC"
}

variable "ingress_cidr_blocks" {
  description = "Work station CIDR IP blocks that can access the EKS API server"
  type = list
}

variable "worker-size" {
  default = "m4.large"
  description = "Size of worker nodes to add to EKS cluster"
  type = "string"
}
variable "worker_desired_capacity" {
  default = 2
  description = "Desired number of worker nodes to add to the EKS cluster"
}
variable "worker_max_capacity" {
  default = 2
  description = "Max number of worker nodes to add to the EKS cluster"
}
variable "worker_min_capacity" {
  default = 1
  description = "Minimum number of workers nodes to add to the EKS cluster"
}