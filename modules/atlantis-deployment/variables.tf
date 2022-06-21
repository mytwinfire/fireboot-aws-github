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

variable "atlantis_repo_allowlist" {
  description = "List of names of repositories which belong to the owner specified in `github_owner`"
  type        = list(string)
}

variable "aws_access_key" {
  description = "aws access key"
  type        = string
}

variable "aws_secret_token" {
  description = "aws secret token"
  type        = string
}
