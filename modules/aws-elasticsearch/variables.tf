variable "elasticsearch_domain_name" {
  description = "Name of the domain."
}
variable "elasticsearch_version" {
  description = "The version of ElasticSearch to deploy."
}
variable "elasticsearch_instnace_type" {
  description = "Instance type of data nodes in the cluster."
}
variable "elasticsearch_ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes in the domain."
}
variable "elasticsearch_volume_type" {
  description = "The type of EBS volumes attached to data nodes."
}
variable "elasticsearch_volume_size" {
  description = "The size of EBS volumes attached to data nodes (in GB). Required if ebs_enabled is set to true."
}
variable "elasticsearch_rest_index" {
  description = ""
}
variable "elasticsearch_subnet" {
  type = "list"
  description = "List of VPC Subnet IDs for the Elasticsearch domain endpoints to be created in."
}
variable "elasticsearch_security_group_ids" {
  type = "list"
  description = "List of VPC Security Group IDs to be applied to the Elasticsearch domain endpoints. If omitted, the default Security Group for the VPC will be used."
}
variable "elasticsearch_automated_snapshot_start_hour" {
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain."
}