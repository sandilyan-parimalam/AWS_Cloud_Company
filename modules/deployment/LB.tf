# Service
resource "kubernetes_service" "dev_web_lb" {
  metadata {
    name      = "dev-web-lb"
    namespace = kubernetes_namespace.development.metadata[0].name
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "web-nginx-app"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
  }
}