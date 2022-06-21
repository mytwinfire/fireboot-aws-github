variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

variable "create_github_repository_webhook" {
  description = "Whether to create Github repository webhook for Atlantis"
  type        = bool
  default     = true
}

variable "github_base_url" {
  description = "Github base URL to use when creating webhook (when using GitHub Enterprise)"
  type        = string
  default     = null
}

variable "github_user" {
  description = "Github user to use when executing Atlantis commands"
  type        = string
  default     = ""
}

variable "github_token" {
  description = "Github token to use when creating webhook"
  type        = string
  default     = ""
}

variable "github_owner" {
  description = "Github owner to use when creating webhook"
  type        = string
  default     = ""
}

variable "atlantis_repo_allowlist" {
  description = "List of names of repositories which belong to the owner specified in `github_owner`"
  type        = list(string)
}

variable "webhook_url" {
  description = "Webhook URL"
  type        = string
  default     = ""
}

variable "webhook_secret" {
  description = "Webhook secret"
  type        = string
  default     = ""
}

variable "aws_access_key" {
  description = "aws access key"
  type        = string
}

variable "aws_secret_token" {
  description = "aws secret token"
  type        = string
}