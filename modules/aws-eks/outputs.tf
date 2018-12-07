output "eks-vpc" {
  value = "${aws_vpc.eks.id}"
}
output "eks-subnet-ids" {
  value = "${aws_subnet.eks.*.id}"
}
output "eks-sg" {
  value = "${aws_security_group.worker-node.id}"
}
