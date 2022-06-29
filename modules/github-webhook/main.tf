provider "github" {
  token = var.github_token
  owner = var.github_owner
}

resource "github_repository_webhook" "this" {
  count = var.create_github_repository_webhook ? length(var.atlantis_repo_allowlist) : 0

  repository = var.atlantis_repo_allowlist[count.index]
  #repository = "atlantis-test"

  configuration {
    url = var.webhook_url
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
