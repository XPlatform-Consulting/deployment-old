output "MASTERS_PRIVATE_IP" {
  value = "${module.aws-ec2-master.private_ip}"
}
output "WORKERS_PRIVATE_IP" {
  value = "${module.aws-ec2-worker.private_ip}"
}
output "MASTERS_PUBLIC_IP" {
  value = "${module.aws-ec2-master.public_ip}"
}
output "WORKERS_PUBLIC_IP" {
  value = "${module.aws-ec2-worker.public_ip}"
}
output "masters_id" {
  value = "${module.aws-ec2-master.id}"
}
output "workers_id" {
  value = "${module.aws-ec2-worker.id}"
}