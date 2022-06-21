resource "kubernetes_stateful_set" "atlantis" {
  metadata {
    annotations = {
      atlantis = "atlantis"
    }

    labels = {
      k8s-app                           = "atlantis"
      "kubernetes.io/cluster-service"   = "true"
      "addonmanager.kubernetes.io/mode" = "Reconcile"
    }

    name = "atlantis"
  }

  spec {
    pod_management_policy  = "Parallel"
    replicas               = 1
    revision_history_limit = 5

    selector {
      match_labels = {
        k8s-app = "atlantis"
      }
    }

    service_name = "atlantis"

    template {
      metadata {
        labels = {
          k8s-app = "atlantis"
        }

        annotations = {}
      }

      spec {

        security_context {
          fs_group = 1000
        }

        container {
          name              = "atlantis"
          image             = "runatlantis/atlantis:latest"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 4141
          }

          env {
            name  = "ATLANTIS_REPO_ALLOWLIST"
            value = join(",", var.atlantis_repo_allowlist)
          }
          env {
            name  = "ATLANTIS_GH_USER"
            value = var.github_user
          }
          env {
            name  = "ATLANTIS_GH_TOKEN"
            value = var.github_token
          }
          env {
            name  = "ATLANTIS_GH_WEBHOOK_SECRET"
            value = var.webhook_secret
          }
          env {
            name  = "AWS_ACCESS_KEY_ID"
            value = var.aws_access_key
          }
          env {
            name  = "AWS_SECRET_ACCESS_KEY"
            value = var.aws_secret_token
          }
          env {
            name  = "ATLANTIS_DATA_DIR"
            value = "/atlantis"
          }
          env {
            name  = "ATLANTIS_PORT"
            value = "4141"
          }

          resources {
            limits = {
              cpu    = "100m"
              memory = "256Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "256Mi"
            }
          }

          volume_mount {
            name       = "atlantis-data"
            mount_path = "/atlantis"
            sub_path   = ""
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = 4141
            }

            initial_delay_seconds = 30
            timeout_seconds       = 30
          }

          liveness_probe {
            http_get {
              path   = "/healthz"
              port   = 4141
              scheme = "HTTP"
            }

            initial_delay_seconds = 30
            timeout_seconds       = 30
          }
        }

        termination_grace_period_seconds = 300

      }
    }

    update_strategy {
      type = "RollingUpdate"

      rolling_update {
        partition = 0
      }
    }

    volume_claim_template {
      metadata {
        name = "atlantis-data"
      }

      spec {
        access_modes = ["ReadWriteOnce"]

        resources {
          requests = {
            storage = "5Gi"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "atlantis" {
  metadata {
    name = "atlantis"
  }
  spec {
    selector = {
      k8s-app = "atlantis"
    }

    port {
      port        = 80
      target_port = 4141
    }

    type = "LoadBalancer"
  }
}
