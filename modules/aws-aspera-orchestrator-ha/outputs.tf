output "swarm_master_private_ip" {
  value = "${module.aws-docker-swarm.MASTERS_PRIVATE_IP}"
}
output "swarm_workers_private_ip" {
  value = "${module.aws-docker-swarm.WORKERS_PRIVATE_IP}"
}
output "rds_cluster_endpoints" {
  value = "${module.aws-aurora.aurora_endpoint}"
}
output "swarm_master_public_ip" {
  value = "${module.aws-docker-swarm.MASTERS_PUBLIC_IP}"
}
output "swarm_workers_public_ip" {
  value = "${module.aws-docker-swarm.WORKERS_PUBLIC_IP}"
}