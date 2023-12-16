output "k8_cluster" {
  description = "Cluster End Point"
  value = aws_eks_cluster.dev_web_eks_cluster.endpoint
}