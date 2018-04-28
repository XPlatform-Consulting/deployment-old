resource "aws_security_group" "swarm" {
  vpc_id      = "${var.vpc_id}"
  description = "Docker Swarm security group."
  name        = "Docker Swarm"
  # Allow all inbound
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "aws-ec2-worker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.3.0"
  name = "${var.ec2_worker_name}"
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.ec2_instace_type}"
  key_name = "${var.ec2_key_name}"
  monitoring = "true"
  vpc_security_group_ids = ["${aws_security_group.swarm.id}", "${var.security_group_ids}"]
  subnet_id = "${var.ec2_subnet_id}"
  instance_count = "${var.worker_count}"
  root_block_device = [{volume_size = 80}]
  associate_public_ip_address = true
}

module "aws-ec2-master" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.3.0"
  name = "${var.ec2_master_name}"
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.ec2_instace_type}"
  key_name = "${var.ec2_key_name}"
  monitoring = "true"
  vpc_security_group_ids = ["${aws_security_group.swarm.id}", "${var.security_group_ids}"]
  subnet_id = "${var.ec2_subnet_id}"
  instance_count = "${var.master_count}"
  root_block_device = [{volume_size = 80}]
  associate_public_ip_address = true
}
