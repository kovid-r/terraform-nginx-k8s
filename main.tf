provider "kubernetes" {
  host                   = var.kubernetes_host
  client_certificate     = file(var.kubernetes_client_certificate)
  client_key             = file(var.kubernetes_client_key)
  cluster_ca_certificate = file(var.kubernetes_cluster_ca_certificate)
}

resource "kubernetes_namespace" "nginx" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.nginx.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = var.replicas

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
          image = "nginx:${var.nginx_version}"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.nginx.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = var.service_type
  }
}
