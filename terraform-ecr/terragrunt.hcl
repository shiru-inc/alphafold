remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = "shiru-shared-ecr-terraform"
    key     = "alphafold/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

iam_role = "arn:aws:iam::301451991843:role/Shared-Account-Admin"

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  version = "~> 3.22.0"
  region  = "us-west-2"
  allowed_account_ids = ["301451991843"]
}
EOF
}
