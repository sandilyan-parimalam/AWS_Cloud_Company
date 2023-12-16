# Namespace
resource "kubernetes_namespace" "development" {
  metadata {
    name = "development"
  }
}

# Deployment
resource "kubernetes_deployment" "dev_web_deployment" {
  metadata {
    name      = "dev-web-deployment"
    namespace = kubernetes_namespace.development.metadata[0].name
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
