resource "aws_elasticsearch_domain" "default" {
  domain_name           = "${var.elasticsearch_domain_name}"
  elasticsearch_version = "${var.elasticsearch_version}"
  cluster_config {
    instance_type = "${var.elasticsearch_instnace_type}"
  }

  ebs_options {
    ebs_enabled = "${var.elasticsearch_ebs_enabled}"
    volume_type = "${var.elasticsearch_volume_type}"
    volume_size = "${var.elasticsearch_volume_size}"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "${var.elasticsearch_rest_index}"
  }

  vpc_options {
    subnet_ids = ["${var.elasticsearch_subnet}"]
    security_group_ids = ["${var.elasticsearch_security_group_ids}"]
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.elasticsearch_automated_snapshot_start_hour}"
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Action": [
        "es:*"
      ],
      "Resource": "arn:aws:es:us-east-1:524540001196:domain/${var.elasticsearch_domain_name}/*"
    }
  ]
}
CONFIG

}
