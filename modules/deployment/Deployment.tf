resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name = "nginx-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx_service" {
  metadata {
    name = "nginx-service"
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      protocol   = "TCP"
      port       = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

output "load_balancer_spec" {
  value = try(
    kubernetes_service.nginx_service.status[0].load_balancer.ingress[0].ip,
    "Load balancer IP not available"
  )}
