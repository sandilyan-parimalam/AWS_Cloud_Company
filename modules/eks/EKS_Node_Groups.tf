resource "aws_eks_node_group" "dev_web_eks_node_group" {
  node_group_name = var.dev_web_eks_node_group
  cluster_name    = aws_eks_cluster.dev_web_eks_cluster.name
  instance_types  = [var.web_server_instance_type]
  remote_access {
    ec2_ssh_key = var.web_server_instance_key_name
  }

  subnet_ids = [
    module.vpc.dev_web_subnet_id,
    module.vpc.dev_web_subnet_1_id,
  ]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  capacity_type = "ON_DEMAND"
  node_role_arn = aws_iam_role.dev_web_eks_node_iam_role.arn
  depends_on = [
    aws_iam_role.dev_web_eks_node_iam_role,
  ]
}