output "amazonmq_endpoints" {
  value = "${aws_mq_broker.envoi-vidispine-mq.instances.0.endpoints}"
}