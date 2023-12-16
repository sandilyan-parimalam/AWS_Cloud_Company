resource "kubernetes_service" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      app = "MyExampleApp"
    }
  }

  spec {
    selector = {
      app = "MyExampleApp"
    }

    port {
      protocol   = "TCP"
      port       = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}