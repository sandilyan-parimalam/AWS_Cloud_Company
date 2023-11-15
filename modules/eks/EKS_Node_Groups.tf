resource "aws_eks_node_group" "dev_web_eks_node_group" {
  node_group_name = var.dev_web_eks_node_group
  cluster_name    = aws_eks_cluster.dev_web_eks_cluster.name
  instance_types  = [var.web_server_instance_type, ]
  remote_access {
    ec2_ssh_key = var.web_server_instance_key_name
  }


  subnet_ids = [
    aws_subnet.dev_web_subnet.id,
    aws_subnet.dev_web_subnet_1.id,
  ]


  scaling_config {
    desired_size = "1"
    min_size     = "1"
    max_size     = "2"
  }

  update_config {
    max_unavailable = 1
  }

  capacity_type = "ON_DEMAND"
  #node_group_name_prefix = "dev_web_eks_node_"
  node_role_arn = aws_iam_role.dev_web_eks_node_iam_role.arn
  depends_on = [
    aws_iam_role.dev_web_eks_node_iam_role,
  ]


  provisioner "local-exec" {
    command = "~/kubectl apply -n dev -f K8_Manifests/Dev_Web_Manifest.yaml"
  }

}

resource "null_resource" "wait_for_lb_ip" {
  triggers = {
    cluster_name = aws_eks_cluster.dev_web_eks_cluster.name
  }

  provisioner "local-exec" {
    command = <<-EOT
      retries=0
      max_retries=30
      lb_public_ip=""
      until [ "\$retries" -ge "\$max_retries" ]; do
        lb_public_ip=\$(kubectl get services -n dev -o=jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}')
        [ -n "\$lb_public_ip" ] && break
        retries=\$((retries+1))
        sleep 10
      done
      [ -z "\$lb_public_ip" ] && echo "Error: Load Balancer IP not available after \$max_retries retries" && exit 1
      echo "Load Balancer IP: \$lb_public_ip"
    EOT
  }
}
