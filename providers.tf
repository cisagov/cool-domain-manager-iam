# This is the "default" provider that is used to obtain the caller's
# credentials, which are used to set the session name when assuming roles in
# the other providers.

provider "aws" {
  region = var.aws_region
}

# The provider used to create resources inside the Users account.
provider "aws" {
  alias  = "users"
  region = var.aws_region
  assume_role {
    role_arn     = data.terraform_remote_state.users.outputs.provisionaccount_role.arn
    session_name = local.caller_user_name
  }
}
