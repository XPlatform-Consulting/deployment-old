output "amazonmq_endpoints" {
  value = "${aws_mq_broker.vidispine-mq.instances.0.endpoints}"
}