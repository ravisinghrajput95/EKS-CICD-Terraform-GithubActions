resource "kubernetes_deployment" "nodeapp" {
  metadata {
    name = "nodeapp"
    labels = {
      test = "nodeapp"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        test = "nodeapp"
      }
    }
    template {
      metadata {
        labels = {
          test = "nodeapp"
        }
      }
      spec {
        container {
          image = "230418669082.dkr.ecr.ap-south-1.amazonaws.com/node-app:9c797a6f5609fc06c954a3fed9369dfddb601072"
          name  = "nodeapp"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nodeapp-service" {
  metadata {
    name = "nodeapp-service"
  }

  spec {
    selector = {
      test = "nodeapp-service"
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 30010
    }

    type = "LoadBalancer"
  }
}
