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

output "load_balancer_url" {
  value = "${kubernetes_service.nginx_service.load_balancer_ingress[0].ip}:${kubernetes_service.nginx_service.ports[0].node_port}"
}