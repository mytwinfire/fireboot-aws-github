module "atlantis" {
  source = "./modules/atlantis-deployment"

  atlantis_repo_allowlist = ["github.com/${var.github_owner}/atlantis-test"]
  github_user = var.github_user
  github_token = var.github_token
  webhook_secret = var.webhook_secret
  aws_access_key = var.aws_access_key
  aws_secret_token = var.aws_secret_token
}
