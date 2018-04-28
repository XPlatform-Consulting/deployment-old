variable "private-subnets" {
  type = "list"
  description = "A list of VPC subnet IDs."
}
variable "elasticache_subnet_group" {
  description = "The name of the elasticache subnet group."
}
variable "elasticache_cluser_id" {
  description = "Group identifier."
}
variable "elasticache_engine" {
  description = "Name of the cache engine to be used for this cache cluster."
}
variable "elasticache_node_type" {
  description = "The compute and memory capacity of the nodes."
}
variable "elasticache_cluster_port" {
  description = "The port number on which each of the cache nodes will accept connections."
}
variable "num_cache_nodes" {
 description = "The initial number of cache nodes that the cache cluster will have."
}
variable "parameter_group_name" {
  default = "Name of the parameter group to associate with this cache cluster."
}
variable "elasticache_security_group_id" {
  type = "list"
  description = "VPC security group to associate with the Cluster."
}