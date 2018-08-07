AWS Docker Swarm
================
Terraform module which creates a new docker swarm in AWS.
## Example Usage 
```hcl
module "aws-docker-swarm" {
  source = "../../"
  vpc_id = "${data.aws_vpc.default.id}"
  ec2_subnet_id = "${element(data.aws_subnet_ids.all.ids, 1)}"
  ec2_master_name = "swarm_master"
  ec2_worker_name = "swarm_worker"
  master_count = "1"
  worker_count= "2"
  ec2_instance_type = "m5.large"
  ec2_key_name = "damedash-dev"
}
```
An Ansible playbook is also included in the example. This is used to install and configure the docker swarm.
### Usage: 
Fill in the hosts file with the private ip addresses of your containers. The file should look something like the following:
```
[masters]
172.31.23.64

[workers]
172.31.18.81
172.31.20.124
```
Now run the playbook with:
```$xslt
ansible-playbook --key-file {path to key} -i hosts playbook.yml
```