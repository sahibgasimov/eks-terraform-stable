output "SomeOutput" {
  value = aws_eks_cluster.dev.aws_subnet.private-1.id
}
