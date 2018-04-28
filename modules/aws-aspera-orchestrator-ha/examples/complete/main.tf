provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}
data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}


module "aws-aspera-orchestrator-ha" {
  source = "../../"
  vpc_id = "${data.aws_vpc.default.id}"
  subnets = "${data.aws_subnet_ids.all.ids}"

  ec2_name = "terraform-orchestrator-ha-test"
  ec2_key_name = "damedash-dev"
  ec2_instace_type = "t2.micro"
  ec2_instace_count = 2
  ec2_ami = "ami-1853ac65"

  aurora_database_name = "orchestrator_ha_test"
  aurora_master_username = "orchestrator"
  aurora_master_password = "orchestrator123"
  aurora_cluster_identifier = "orchestrator-ha-test"
  aurora_instance_count = "2"
  aurora_instance_class = "db.t2.small"
  aurora_subnet_group_name = "orchestrator-test"

  elb_name = "orchestratortest"
}

resource "null_resource" "provision" {
  depends_on = ["module.aws-aspera-orchestrator-ha"]
  provisioner "local-exec" {
    command = "echo ${module.aws-aspera-orchestrator-ha.ec2_private_ip} >> private_ip.txt"
  }
}