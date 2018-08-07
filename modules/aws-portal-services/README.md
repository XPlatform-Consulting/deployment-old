AWS Cantemo Portal services Terraform module
============================================
Terraform module which creates all the aws services to run Cantemo Portal.
## Example Usage 
```hcl
module "portal" {
  source = "modules/aws-portal-services"

  vpc_id = "${var.vpc_id}"
  private-subnets = ["${var.private_subnet_1}", "${var.private_subnet_2}"]

  #Portal Elasticsearch
  elasticsearch_domain_name = "portal"
  elasticsearch_instance_type = "t2.small.elasticsearch"
  elasticsearch_ebs_enabled = true
  elasticsearch_volume_type = "gp2"
  elasticsearch_volume_size = 10
  elasticsearch_rest_index = "true"
  elasticsearch_automated_snapshot_start_hour = "23"
  elasticsearch_subnet = ["${var.private_subnet_1}"]

  #Portal Elasticache
  elasticache_cluster_port = "11211"
  elasticache_subnet_group = "elasticache-subnet-group"
  elasticache_cluser_id = "elasticcache"
  elasticache_node_type = "cache.t2.micro"
  num_cache_nodes = 1
  parameter_group_name = "default.memcached1.4"

  #Portal RDS Cluster
  cluster_identifier = "portaldb"
  engine_type = "aurora-postgresql"
  engine_version = "9.6"
  database_name = "portaldb"
  master_username = "${var.master_username}"
  master_password = "${var.master_password}"
  availability_zones = ["us-east-1a", "us-east-1b"]
  instance_count = 2
  rds_instance_class = "db.r4.large"
  subnet_group_name = "portaldb"

  #Vidispine
  vidi_availability_zones = ["us-east-1a", "us-east-1b"]
  vidi_cluster_identifier = "vididb"
  vidi_database_name = "vididb"
  vidi_engine_type = "aurora-postgresql"
  vidi_engine_version = "9.6"
  vidi_instance_count = 2
  vidi_master_password = "${var.vidi_master_password}"
  vidi_master_username = "${var.vidi_master_username}"
  vidi_rds_instance_class = "db.r4.large"
  vidi_subnet_group_name = "vididb"
  vidi_broker_name = "vidispine-mq"
  vidi_broker_instance_type = "mq.t2.micro"
  vidi_broker_username = "${var.vidi_broker_username}"
  vidi_broker_password = "${var.vidi_broker_password}"
  vidi_broker_subnet_ids = ["${var.private_subnet_1}"]
}
```
