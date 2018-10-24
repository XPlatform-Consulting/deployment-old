resource "aws_eks_cluster" "eks" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.eks-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.eks-cluster.id}"]
    subnet_ids         = ["${aws_subnet.eks.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy",
  ]
}

data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_region" "current" {}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  worker-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}

resource "aws_launch_configuration" "workers" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.worker-node.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "${var.worker-size}"
  name_prefix                 = "${var.cluster-name}-worker-nodes"
  security_groups             = ["${aws_security_group.worker-node.id}"]
  user_data_base64            = "${base64encode(local.worker-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "workers" {
  desired_capacity     = "${var.worker_desired_capacity}"
  launch_configuration = "${aws_launch_configuration.workers.id}"
  max_size             = "${var.worker_max_capacity}"
  min_size             = "${var.worker_min_capacity}"
  name                 = "${var.cluster-name}-worker-nodes"
  vpc_zone_identifier  = ["${aws_subnet.eks.*.id}"]

  tag {
    key                 = "Name"
    value               = "${var.cluster-name}-worker-nodes"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
