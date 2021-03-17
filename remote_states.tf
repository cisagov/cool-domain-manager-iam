# ------------------------------------------------------------------------------
# Retrieves state data from a Terraform backend. This allows use of the
# root-level outputs of one or more Terraform configurations as input data
# for this configuration.
# ------------------------------------------------------------------------------

data "terraform_remote_state" "domainmanager_production" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-accounts-domain-manager/terraform.tfstate"
  }

  workspace = "production"
}

data "terraform_remote_state" "domainmanager_staging" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-accounts-domain-manager/terraform.tfstate"
  }

  workspace = "staging"
}

data "terraform_remote_state" "domainmanager_networking_staging" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-domain-manager-networking/terraform.tfstate"
  }

  workspace = "staging"
}

data "terraform_remote_state" "sharedservices_networking_production" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-sharedservices-networking/terraform.tfstate"
  }

  workspace = "production"
}

data "terraform_remote_state" "sharedservices_networking_staging" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-sharedservices-networking/terraform.tfstate"
  }

  workspace = "staging"
}

data "terraform_remote_state" "terraform" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-accounts/terraform.tfstate"
  }

  workspace = "production"
}

data "terraform_remote_state" "users" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-accounts/users.tfstate"
  }

  workspace = "production"
}
