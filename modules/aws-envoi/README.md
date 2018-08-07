AWS Envoi services Terraform module
===================================
Terraform module which creates all the aws services to run Envoi.
## Example Usage 
```hcl
module "envoi" {
  source = "modules/envoi"
  vpc_id = "${var.vpc_id}"
  private-subnets = ["", ""]
  #Elasticsearch
  elasticsearch_domain_name = "envoi-portal"
  elasticsearch_version = "1.5"
  elasticsearch_instance_type = "t2.small.elasticsearch"
  elasticsearch_ebs_enabled = true
  elasticsearch_volume_type = "gp2"
  elasticsearch_volume_size = 10
  elasticsearch_rest_index = "true"
  elasticsearch_automated_snapshot_start_hour = "23"
  elasticsearch_subnet = [""]
  #RDS Cluster
  cluster_identifier = "envoi-portaldb"
  engine_type = "aurora-postgresql"
  engine_version = "9.6"
  database_name = "portaldb"
  master_username = "${var.master_username}"
  master_password = "${var.master_password}"
  availability_zones = ["us-east-1a", "us-east-1b"]
  instance_count = 2
  rds_instance_class = "db.r4.large"
  subnet_group_name = "envoi-portaldb"
  #EC2 Instance
  ec2_name = "envoi"
  ec2_count = "1"
  ec2_key_name = "dame-dashdev"
  ec2_subnet_id = ""
  ec2_instance_type = "t2.micro"
}
```
