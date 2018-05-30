AWS Vidispine services Terraform module
=======================================
Terraform module which creates all the aws services to run Vidispine.
## Example Usage 
```hcl
mmodule "aws-vidispine-services" {
   source = "../aws-vidispine-services"
   vpc_id = "${var.vpc_id}"
   private_subnet_ids = "${var.private-subnets}"
   vidi_cluster_identifier = "${var.vidi_cluster_identifier}"
   vidi_database_name = "${var.vidi_database_name}"
   vidi_instance_count = "${var.vidi_instance_count}"
   vidi_master_password = "${var.vidi_master_password}"
   vidi_master_username = "${var.vidi_master_username}"
   vidi_rds_instance_class = "${var.vidi_rds_instance_class}"
   vidi_subnet_group_name = "${var.vidi_subnet_group_name}"
   vidi_broker_name = "${var.vidi_broker_name}"
   vidi_broker_instance_type = "${var.vidi_broker_instance_type}"
   vidi_broker_username = "${var.vidi_broker_username}"
   vidi_broker_password = "${var.vidi_broker_password}"
 }
```
