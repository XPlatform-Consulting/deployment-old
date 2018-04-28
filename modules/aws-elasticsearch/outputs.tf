output "elasticsearch_endpoint" {
  value = "${aws_elasticsearch_domain.default.endpoint}"
}