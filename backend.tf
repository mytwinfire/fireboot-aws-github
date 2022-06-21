terraform {
  backend "s3" {
    bucket         = "twinfire-terraform-state"
    key            = "atlantis/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    kms_key_id     = "alias/terraform-bucket-key"
    dynamodb_table = "terraform-state"
  }
}
