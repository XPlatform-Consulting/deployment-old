output "orchestrator_public_ip" {
  value = "${module.aws-ec2.public_ip}"
}
output "orchestrator_private_ip" {
  value = "${module.aws-ec2.private_ip}"
}
output "rds_endpoint" {
  value = "${module.aws-aurora.aurora_endpoint}"
}