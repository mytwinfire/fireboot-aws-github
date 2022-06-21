provider "github" {
  token = var.github_token
  owner = var.github_owner
}

resource "github_repository_webhook" "this" {
  count = var.create_github_repository_webhook ? length(var.atlantis_repo_allowlist) : 0

  repository = var.atlantis_repo_allowlist[count.index]
  #repository = "atlantis-test"

  configuration {

    #url = "http://${var.webhook_url}/events"
    url = var.webhook_url
    #url = "http://${data.kubernetes_service.atlantis.status[0].load_balancer[0].ingress[0].hostname}/events"

    content_type = "application/json"
    insecure_ssl = true
    secret       = var.webhook_secret
  }

  events = [
    "issue_comment",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
  ]
}
