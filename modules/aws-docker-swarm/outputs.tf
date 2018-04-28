output "MASTERS" {
  value = "${module.aws-ec2-master.private_ip}"
}
output "WORKERS" {
  value = "${module.aws-ec2-worker.private_ip}"
}