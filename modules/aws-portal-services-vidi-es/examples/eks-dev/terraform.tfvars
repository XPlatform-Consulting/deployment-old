aws_region = "us-west-2"
eks_ingress_cidr_block = "10.1.1.1/32"
portal_rds_master_password = "portal123"
portal_rds_master_username = "portal"
vidi_rds_master_password = "vidispine123"
vidi_rds_master_username = "vidispine"
vidi_broker_password = "vidispine123"
vidi_broker_username = "vidispine"
activiti_rds_master_username = "portal"
activiti_rds_master_password = "portal123"
portal_elasticsearch_domain_name = "portal"
portal_elasticsearch_instance_size = "t2.small.elasticsearch"
portal_elasticsearch_snapshot_start_hour = "23"
portal_elasticache_cluster_port = "11211"
portal_elasticache_subnet_group_name = "elasticache-subnet"
portal_elasticache_cluster_id = "portal-elasticache"
portal_elasticache_node_size = "cache.t2.micro"
portal_elasticache_node_count = 1
activiti_rds_cluster_identifier = "actvitidb"
activiti_rds_cluster_database_name = "actvitidb"
activiti_rds_cluster_instance_count = 2
activiti_rds_cluster_instance_type = "db.r4.large"
activiti_rds_cluster_subnet_group_name = "activitidb-group"
portal_rds_cluster_identifier = "portaldb"
portal_rds_cluster_database_name = "portaldb"
portal_rds_cluster_instance_count = 2
portal_rds_cluster_instance_type = "db.r4.large"
portal_rds_cluster_subnet_group_name = "portaldb-group"
vidi_rds_cluster_identifier = "vidispinedb"
vidi_rds_cluster_database_name = "vidispinedb"
vidi_rds_cluster_instance_count = 2
vidi_rds_cluster_instance_size = "db.r4.large"
vidi_rds_cluster_subnet_group_name = "vidispinedb-group"
vidi_broker_name = "vidispine-413-mq"
vidi_broker_instance_type = "mq.t2.micro"
vidi_elasticsearch_domain_name = "vidispine"
vidi_elasticsearch_instance_type = "t2.small.elasticsearch"
vidi_elasticsearch_automated_snapshot_start_hour = "23"
eks_worker_size = "t2.xlarge"
eks_worker_desired_capacity = "3"
eks_worker_max_capacity = "4"
eks_worker_min_capacity = "1"