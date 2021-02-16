# IAM policy document that allows assumption of the ProvisionDomainManager
# role in the User Services account
data "aws_iam_policy_document" "assume_provisiondomainmanager_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      # TODO: Uncomment line below after Production role has been created
      #       See https://github.com/cisagov/cool-accounts-userservices/pull/3
      # data.terraform_remote_state.userservices_production.outputs.provisiondomainmanager_role.arn,
      data.terraform_remote_state.userservices_staging.outputs.provisiondomainmanager_role.arn,
    ]
  }
}

resource "aws_iam_policy" "assume_provisiondomainmanager_role" {
  provider = aws.users

  description = var.assume_provisiondomainmanager_policy_description
  name        = var.assume_provisiondomainmanager_policy_name
  policy      = data.aws_iam_policy_document.assume_provisiondomainmanager_role_doc.json
}

# Attach the policy to the provisioners users group
resource "aws_iam_group_policy_attachment" "assume_provisiondomainmanager_role_attachment" {
  provider = aws.users

  group      = aws_iam_group.provisioner_users.name
  policy_arn = aws_iam_policy.assume_provisiondomainmanager_role.arn
}
