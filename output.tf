
output "cluster_enpoint" {
  value = module.eks.cluster_enpoint
}

output "load_balancer_spec" {
  value = module.deployment.load_balancer_spec
}