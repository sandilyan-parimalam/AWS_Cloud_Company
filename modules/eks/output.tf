output "cluster_enpoint" {
  description = "Cluster End Point"
  value = aws_eks_cluster.dev_web_eks_cluster.endpoint
}
output "cluster_cert" {
  description = "Cluster End Point"
  value = aws_eks_cluster.dev_web_eks_cluster.cluster_ca_certificate
}