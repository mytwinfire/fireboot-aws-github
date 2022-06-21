module "github_webhook" {
  source = "./modules/github-webhook"
  atlantis_repo_allowlist = var.atlantis_repo_allowlist
  webhook_url = "http://${data.kubernetes_service.atlantis.status[0].load_balancer[0].ingress[0].hostname}/events"
  webhook_secret = var.webhook_secret
  github_owner = var.github_owner
  github_token = var.github_token
}


data "kubernetes_service" "atlantis" {
  metadata {
    name = "atlantis"
  }
  depends_on = [module.atlantis]
}
