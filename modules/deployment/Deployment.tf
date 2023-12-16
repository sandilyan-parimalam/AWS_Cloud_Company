# Namespace
resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}

# Deployment
resource "kubernetes_deployment" "dev_web_deployment" {
  metadata {
    name      = "dev-web-deployment"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "web-nginx-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "web-nginx-app"
        }
      }

      spec {
        container {
          name  = "web-nginx-app-container"
          image = "sandilyanparimalam/testinfra"
          # imagePullPolicy = "Always" # Uncomment if needed
          
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
